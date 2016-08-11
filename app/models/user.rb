class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, , :timeoutable and :reecoverable
  enum gender: [ :nan,:male , :female]

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  devise :database_authenticatable, :registerable,
         :lockable,:rememberable, :omniauthable, :recoverable,:trackable,:confirmable, :validatable

  has_many :user_reports, class_name: 'Report', foreign_key: :sender_id
  has_many :reports, as: :reportable
  has_many :posts

  validates :login, uniqueness: true, presence: true

  validate :check_date_of_birth

  # after_create do 
  #   #DeviseMailer.welcome_email(self.email).deliver_later
  # end

 def check_date_of_birth
    from = 16.years.ago.to_date
    to = 200.years.ago.to_date
    if date_of_birth.present?
      errors.add(:date_of_birth,'Date of birth lesser than accepted') unless date_of_birth < from
      errors.add(:date_of_birth,"Are u joking?, youre really: #{Date.current.year - date_of_birth.year}") unless date_of_birth > to
    end

  end 


  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

#binding.pry
    user.email = auth.info.email
    user.login = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    if auth.info.first_name
       user.first_name = auth.info.first_name       
       user.last_name = auth.info.last_name
    else
      user.first_name = auth.info.name.split(' ')[0]
      user.last_name = auth.info.name.split(' ')[1]
    end

   # user.image = auth.info.image # assuming the user model has an image
  end
end

def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
       # user.first_name = data["first_name"] if user.first_name.blank?
      end
    end
  end
  


 # Search user by first_name, last_name, email, login
 searchable do
   text :login, :email
   text :first_name, :last_name
 end


end
