class AddUserRefAndLibraryShowToAttachment < ActiveRecord::Migration[5.0]
  def change
    add_reference :attachments, :user, foreign_key: true
    add_column :attachments, :library_show, :boolean
    change_column_default :attachments,:library_show, from: nil,to: false
  end
end
