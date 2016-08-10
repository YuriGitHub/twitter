class Post < ApplicationRecord
	belongs_to :user
	has_many :likes
	has_many :images
	has_many :comments


	validate :text, length: { in: 10...140}
	validate :text, :user_id, presence: true
end
