class Post < ApplicationRecord
    
    belongs_to :user
    has_many :likes
    has_many :attachments
    has_many :comments, as: :commentable, dependent: :destroy
    has_many :reports, as: :reportable

    validates :text, length: { in: 5...500}
    validates :text, :user_id, presence: true

    enum post_type: [:tweet, :post]

    attr_accessor :videos
    attr_accessor :images
    attr_accessor :audio

    def set_attachments
        self.images = self.attachments.image
        self.videos = self.attachments.video
        self.audio = self.attachments.audio
    end

        #search posts by text
        searchable do
            text :text
        end
end
