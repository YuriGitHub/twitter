class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :message
      t.integer :sender
      t.belongs_to :chat_rooms, index: true
      t.timestamps
    end
  end
end
