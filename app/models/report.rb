class Report < ApplicationRecord
    belongs_to :sender_user, class_name: 'User',foreign_key: :sender_id
    belongs_to :reported_user, class_name: 'User',foreign_key: :reported_id

    validate :report_tex, length: { minimum: 30 }, presence: true
    validate :type_of_report, :reported_id, :sender_id, presence: true
    
end
