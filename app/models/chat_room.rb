class ChatRoom < ApplicationRecord
  has_many :messages
  has_many :users
  belongs_to :main, class_name: 'User',foreign_key: :head_of_room
end
