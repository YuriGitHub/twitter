class ChatRoom < ApplicationRecord

  belongs_to :user
  has_many :messages

    def self.get_chat_room_by_users_array(users)
      if(users.instance_of? Array)

        self.find_by("users = ARRAY[?]::integer[]",users.sort)
      end
    end



    def get_another_user_from_chat_room
      self.users.each do |u|
        if u != current_user.id
          return User.find(u)
        end
      end
    end
end
