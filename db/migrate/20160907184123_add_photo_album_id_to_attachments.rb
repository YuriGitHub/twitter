class AddPhotoAlbumIdToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :photo_album_id, :integer
  end
end
