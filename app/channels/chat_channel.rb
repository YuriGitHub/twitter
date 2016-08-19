# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    unless(params['id'].blank?)

    stream_from "chat#{params['id']}"

  end
  end

  def unsubscribed
    puts "unsibscribed"
  end
  def send_message(data)
    puts data['text']
    puts self.current_user
    ActionCable.server.broadcast "chat#{params['id']}", message: data['text'], sender: User.find_by(email: self.current_user).login
  end
end
