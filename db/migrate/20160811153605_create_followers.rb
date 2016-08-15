class CreateFollowers < ActiveRecord::Migration[5.0]
  def change
    create_table :followers do |t|
        t.integer :user_id
        t.integer :follower_id
    end
    add_index(:followers, [:user_id, :follower_id], :unique => true)
    add_index(:followers, [:follower_id, :user_id], :unique => true)
  end
def self.down
    remove_index(:followers, [:user_id, :follower_id], :unique => true)
    remove_index(:followers, [:follower_id, :user_id], :unique => true)
    drop_table :followers
  end
end
