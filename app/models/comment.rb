class Comment < ApplicationRecord
	belongs_to :post

	validate :text, length: {maximum: 50}
	validate :text, :user_id, :post_id, presence: true
end
