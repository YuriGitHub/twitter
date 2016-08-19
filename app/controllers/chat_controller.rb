class ChatController < ApplicationController

  def index
    @messages = Message.where("(sender_id = ? and receiver_id = ?) or (receiver_id = ? and sender_id = ?)", current_user.id,params[:user_id],current_user.id,params[:user_id])
  end
end
