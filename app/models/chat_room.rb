class ChatRoom < ApplicationRecord

  belongs_to :user
  has_many :messages

    def self.get_chat_room_by_users_array(users)
      return ChatRoom.find_by("users = ARRAY[?]",users.sort)
    end

    def is_chat_room?
      self.user != nil
    end

    def get_another_user_from_chat_room(current_user)
      self.users.each do |u|
        if u != current_user.id
          return User.find(u)
        end
      end
    end
end
