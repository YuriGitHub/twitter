class Post < ApplicationRecord
	belongs_to :user
	has_many :likes
	has_many :images
	has_many :comments
end
