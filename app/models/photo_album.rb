class PhotoAlbum < ApplicationRecord
  belongs_to :user
  has_many :attachments
  validates :name, presence: true

  attr_accessor :images
  def set_attachments
    self.images = self.attachments.image
  end

end
