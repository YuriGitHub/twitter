class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, , :timeoutable and :reecoverable
  enum gender: [ :male , :female]
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  devise :database_authenticatable, :registerable,
         :lockable,:rememberable, :omniauthable, :recoverable,:trackable,:confirmable, :validatable

  has_many :user_reports, class_name: 'Report', foreign_key: :sender_id
  has_many :reports, as: :reportable
  has_many :posts

  validates :login, uniqueness: true, presence: true

  validate :check_date_of_birth

 def check_date_of_birth
    from = 16.years.ago.to_date
    to = 200.years.ago.to_date
    if date_of_birth.present?
      errors.add(:date_of_birth,'Date of birth lesser than accepted') unless date_of_birth < from
      errors.add(:date_of_birth,"Are u joking?, youre really: #{Date.current.year - date_of_birth.year}") unless date_of_birth > to
    end
 end

 # Search user by first_name, last_name, email, login
 searchable do
   text :login, :email
   text :first_name, :last_name
 end

end
