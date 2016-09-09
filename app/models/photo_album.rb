class PhotoAlbum < ApplicationRecord
  belongs_to :user
  has_many :attachments, dependent: :destroy
  validates :name, presence: true
  attr_accessor :flash_notice

  def load_photo(photo_params, user)
    photo = self.photos.build(photo_params)
    photo.user_id = user.id
    unless photo.save
      self.flash_notice = photo.errors.full_messages
    else
      self.flash_notice = 'Photo successfully added.'
    end
  end

  def remove_photo(id)
    photo = self.photos.find(id)
    unless photo.destroy
      self.flash_notice = photo.errors.full_messages
    else
      self.flash_notice = 'Photo successfully removed.'
    end
  end

  def photos
    self.attachments.image
  end

  def name_uniquess(name)
    if User.find(self.user_id).photo_albums.find_by_name(name)
      false
    else
      true
    end
  end

end
