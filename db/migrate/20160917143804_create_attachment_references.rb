class CreateAttachmentReferences < ActiveRecord::Migration[5.0]
  def change
    create_table :attachment_references do |t|
      t.string :attachment_type
      t.integer :attachment_id
      t.integer :user_id

      t.timestamps
    end
  end
end
