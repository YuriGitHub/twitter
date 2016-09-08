class Post < ApplicationRecord

    belongs_to :user
    has_many :likes
    has_many :attachments
    has_many :comments, as: :commentable, dependent: :destroy
    has_many :reports, as: :reportable

    validates :text, length: { in: 5...500}
    validates :text, :user_id, presence: true
    validates :header,length: {in: 5...100}

    attr_accessor :videos
    attr_accessor :images
    attr_accessor :audio

    def short_content(type,length)
        text;
        length = 20 if length == nil or length == 0
        type = "text" if type == nil or type == ""
        text = self.header if type == "header"
        text = self.text if type == "text"
        text[0..length]
    end

    def set_attachments
        self.images = self.attachments.image
        self.videos = self.attachments.video
        self.audio = self.attachments.audio
    end

    #search posts by text
    searchable do
        text :text
        text :header
    end
end
