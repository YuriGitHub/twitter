class AddPolimorhToReport < ActiveRecord::Migration[5.0]
  def change
  	remove_column :reports, :reported_id
  	remove_column :reports, :type_of_report
  	add_column :reports, :reportable_id, :integer
    add_column :reports, :reportable_type, :string
  end
end
