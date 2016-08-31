module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

           def connect
             self.current_user = find_verified_user
             logger.add_tags 'ActionCable Cannoection', current_user
           end
           protected
             def find_verified_user
               puts 'Connecting....'
              id = request.env['QUERY_STRING'].split('=')[1]
              puts 'Connecting....'
               if verified_user = User.find_by(id: id)
                 puts 'Connected'
                 verified_user

               else
                 puts 'Unauthorazition'
                 reject_unauthorized_connection

               end
             end
      end
    end
