class Comment < ApplicationRecord
	belongs_to :post

	validates :text, length: {maximum: 50}
	validates :text, :user_id, :post_id, presence: true
	has_many :reports, as: :reportable
end
