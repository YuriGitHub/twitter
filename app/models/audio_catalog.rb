class AudioCatalog < ApplicationRecord
  belongs_to :user
  has_many :attachments, dependent: :destroy

  validates :name, presence: true

  attr_accessor :flash_notice

  def load_track(track_params, user)
    track = self.tracks.build(track_params)
    track.user_id = user.id
    unless track.save
      self.flash_notice = track.errors.full_messages
    else
      self.flash_notice = 'Track successfully added.'
    end
  end



  def remove_track(id)
    track = self.tracks.find(id)
    unless track.destroy
      self.flash_notice = track.errors.full_messages
    else
      self.flash_notice = 'Track successfully removed.'
    end
  end

  def tracks
    self.attachments.audio
  end
end
