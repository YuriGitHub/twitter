class Attachment < ApplicationRecord
    belongs_to :post
    belongs_to :photo_album
    belongs_to :video_catalog

    mount_uploader :file,FileUploader
    enum file_type: [:video,:audio,:image]

end
