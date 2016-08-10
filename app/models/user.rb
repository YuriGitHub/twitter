class User < ApplicationRecord

  has_many :user_reports, class_name: 'Report', foreign_key: :sender_id
  has_many :reports_on_user, class_name: 'Report', foreign_key: :reported_id
  has_many :posts
  
end
