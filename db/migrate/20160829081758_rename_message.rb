class RenameMessage < ActiveRecord::Migration[5.0]
  def change
    rename_table :messsages, :messages
  end
end
