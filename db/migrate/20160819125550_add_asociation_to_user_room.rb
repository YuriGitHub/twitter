class AddAsociationToUserRoom < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms_users do |t|
      t.belongs_to :users
      t.belongs_to :chat_rooms
      t.timestamps
  
    end
  end
end
