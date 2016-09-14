# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatsChannel < ApplicationCable::Channel
  def subscribed
   unless(current_user.premission?(params[:id]))
     logger.info "subscribed"
     unless(params['id'].blank?)
       stream_from "chat#{params['id']}"
     end
   end
 end

 def unsubscribed

 end

 def send_message(data)
   unless(current_user.premission?(params[:id]))
   Message.create(text_message: data['text'],chat_room_id: params[:id],user_id: current_user.id)
   puts data['text']
   puts self.current_user.login
   ActionCable.server.broadcast "chat#{params['id']}", message: data['text'], image: current_user.avatar(:thumb), login: current_user.login, user_id: current_user.id
 end
 end
end
