class Comment < ApplicationRecord
	belongs_to :commentable, polymorphic: true
	has_many :comments, as: :commentable

	validates :text, length: { in: 1...50}
	validates :text, :user_id, :post_id, presence: true
	has_many :reports, as: :reportable
end
