class AddTokenWsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ws_token, :string
  end
end
