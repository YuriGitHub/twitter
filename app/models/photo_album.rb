class PhotoAlbum < ApplicationRecord
  belongs_to :user
  has_many :attachments, dependent: :destroy
  validates :name, presence: true

  attr_accessor :photos
  def set_attachments
    self.photos = self.attachments.image
  end

end
