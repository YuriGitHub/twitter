class Message < ApplicationRecord
	belongs_to :chat_room
	belongs_to :sender_user, class_name: 'User', foreign_key: :sender
end
