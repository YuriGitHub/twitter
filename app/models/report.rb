class Report < ApplicationRecord
    belongs_to :sender_user, class_name: 'User',foreign_key: :sender_id
    belongs_to :reportable, polymorphic: true


    validates :report_text, length: { minimum: 30, maximum: 300 }, presence: true
    validates :sender_user, presence: true

end
