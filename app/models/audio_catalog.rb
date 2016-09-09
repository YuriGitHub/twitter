class AudioCatalog < ApplicationRecord
  belongs_to :user
  has_many :attachments, dependent: :destroy

  validates :name, presence: true

  def tracks
    self.attachments.audio
  end
end
