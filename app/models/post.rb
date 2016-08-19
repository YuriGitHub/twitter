class Post < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :attachments
    has_many :comments
    has_many :reports, as: :reportable

    validates :text, length: { in: 5...500}
    validates :text, :user_id, presence: true

end
