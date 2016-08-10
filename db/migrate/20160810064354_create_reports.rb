class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
    	t.string :report_text
    	t.integer :reported_id
    	t.integer :sender_id
    	t.integer :type_of_report
    	t.integer :post_id
    	t.integer :comment_id
      t.timestamps
    end
  end
end
