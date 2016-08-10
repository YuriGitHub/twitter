class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
    	t.string :first_name
    	t.string :last_name
    	t.string :login
    	t.date :date_of_birth
    	t.integer :gender
    	t.string :country
    	t.string :city
      t.timestamps
    end
     add_attachment :users, :avatar
  end
end
