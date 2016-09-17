class AddIndexToAttachmentReferences < ActiveRecord::Migration[5.0]
  def change
    add_index :attachment_references, :user_id
    add_index :attachment_references, :attachment_id
  end
end
