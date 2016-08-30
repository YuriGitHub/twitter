class Chat < ActiveRecord::Migration[5.0]
  def change
    drop_table :messages
    create_table :chat_rooms do |t|
      t.string :users, array: true, default: []
      t.references :user
      t.timestamps
    end
    create_table :messsages do |t|
      t.references :user
      t.text :text_message
      t.references :chat_room
      t.timestamps
    end

  end
end
