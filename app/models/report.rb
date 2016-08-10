class Report < ApplicationRecord
    belongs_to :sender_user, class_name: 'User',foreign_key: :sender_id
    belongs_to :reported_user, class_name: 'User',foreign_key: :reported_id

    validates :report_text, length: { minimum: 30 }, presence: true
    validates :type_of_report, :reported_id, :sender_id, presence: true

end
