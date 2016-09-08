class AddAudioCatalogIdToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :audio_catalog_id, :integer
  end
end
