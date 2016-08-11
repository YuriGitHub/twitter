class User < ApplicationRecord

  after_create :reindex!
  after_update :reindex!

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
   text :first_name, :last_name, :email

   string  :sort_login do
      title.downcase.gsub(/^(an?|the)/, '')
    end
 end

 protected
 
  def reindex!
    Sunspot.index!(self)
  end
 
end
