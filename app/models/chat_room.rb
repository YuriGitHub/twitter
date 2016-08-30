class ChatRoom < ApplicationRecord

  belongs_to :user
  has_many :messages

    def self.get_chat_room_by_users_array(users)
      if(users.instance_of? Array)
        self.find_by("users @> ARRAY[?]",users) 
      end
    end
end
