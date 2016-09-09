class AddVideoCatalogIdToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :video_catalog_id, :integer
  end
end
