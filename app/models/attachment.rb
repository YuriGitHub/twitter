class Attachment < ApplicationRecord
    belongs_to :post
    mount_uploader :file,FileUploader
    enum file_type: [:video,:audio,:image]
end
