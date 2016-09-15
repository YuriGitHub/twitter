# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class UsersStatusesChannel < ApplicationCable::Channel

  def subscribed
    stream_from "user_#{current_user.email}"
    $redis.set(current_user.email,true)
  end

  def unsubscribed
    $redis.del(current_user.email)
  end

end
