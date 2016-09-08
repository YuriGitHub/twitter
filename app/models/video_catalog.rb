class VideoCatalog < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :attachments, dependent: :destroy


  def videos
    self.attachments.video
  end
end
