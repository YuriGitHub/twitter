class Attachment < ApplicationRecord
    belongs_to :post
    mount_uploader :file, AttachmentsUploader
    enum type: [:video,:audio,:image]
end
