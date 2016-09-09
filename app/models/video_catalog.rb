class VideoCatalog < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :attachments, dependent: :destroy

  attr_accessor :flash_notice

  def load_video(video_params, user)
    video = self.videos.build(video_params)
    video.user_id = user.id
    unless video.save
      self.flash_notice = video.errors.full_messages
    else
      self.flash_notice = 'Clip successfully added.'
    end
  end


  def remove_video(id)
    video = self.videos.find(id)
    unless video.destroy
      self.flash_notice = video.errors.full_messages
    else
      self.flash_notice = 'Clip successfully removed.'
    end
  end







  def videos
    self.attachments.video
  end


end
