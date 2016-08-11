class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, , :timeoutable and :reecoverable
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
  
end
