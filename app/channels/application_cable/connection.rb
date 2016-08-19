module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

       def connect
         self.current_user = find_verified_user
         logger.add_tags 'ActionCable Cannoection', current_user
       end


       protected
         def find_verified_user
           if verified_user = User.find(cookies.signed['user.id'])
             verified_user.email
           else
             reject_unauthorized_connection
           end
         end
  end
end
