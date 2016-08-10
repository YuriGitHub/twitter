class Report < ApplicationRecord
    belongs_to :sender_user, class_name: 'User',foreign_key: :sender_id
    belongs_to :reported_user, class_name: 'User',foreign_key: :reported_id
end
