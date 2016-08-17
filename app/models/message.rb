class Message < ApplicationRecord
	belongs_to :receiver, class_name: 'User'
	belongs_to :sender, class_name: 'User'

	validates :text, presence: true
	validates :text, length: { in: 1...150}
end
