class AddIndexToUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :login, unique: true
  end
end
