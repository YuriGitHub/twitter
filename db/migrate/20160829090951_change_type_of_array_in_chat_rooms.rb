class ChangeTypeOfArrayInChatRooms < ActiveRecord::Migration[5.0]
  def change
    remove_column :chat_rooms, :users
    add_column :chat_rooms, :users, :integer, array: true, default: []
  end
end
