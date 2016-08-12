class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, , :timeoutable and :reecoverable
  enum gender: [ :nan,:male , :female]
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  devise :database_authenticatable, :registerable,
         :lockable,:rememberable, :omniauthable, :recoverable,:trackable,:confirmable, :validatable

  has_and_belongs_to_many:followers,class_name:"User",join_table:"followers",foreign_key: :user_id,association_foreign_key: :follower_id
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
 #json format fields-----\

    def as_json(options={})
        if self.is_follower !=nil and self.image_url != nil
            options[:methods] = [:follow,:image_url]
        else
            options[:methods] = [:image_url] if self.image_url != nil
            options[:methods] = [:follow] if self.follow != nil and self.image_url != nil
        end
        super
   end

    attr_accessor :is_follower

    def follow
        self.is_follower
    end

    def image_url
        self.avatar.url(:thumb)
    end
 #json format fields-----/

end
