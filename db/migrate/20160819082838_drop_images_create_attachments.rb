class DropImagesCreateAttachments < ActiveRecord::Migration[5.0]
    def change
        drop_table :images
        remove_column :posts, :video, :string
        remove_column :posts, :audio, :string

        create_table :attachments do |t|
            t.integer :type
            t.string :file
            t.integer :post_id
            t.timestamps
        end
    end
end
