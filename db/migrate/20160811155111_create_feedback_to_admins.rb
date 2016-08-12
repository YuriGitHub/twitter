class CreateFeedbackToAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :feedback_to_admins do |t|
    	t.string :feedbacks_text
    	t.integer :user_id
      t.timestamps
    end
  end
end
