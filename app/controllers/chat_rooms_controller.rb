class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def find_chat_room

    if User.find_by(ws_token: cookies[:token]) == nil || User.where(ws_token: cookies[:token]) != current_user
      token = SecureRandom.hex
      cookies[:token] = token
      current_user.update(ws_token: token)
    end
    c = ChatRoom.get_chat_room_by_users_array([current_user.id,params[:user_id]])
    if c == nil
      c = ChatRoom.new
      c.users = [current_user.id,params[:user_id]]
      c.save
    end
    redirect_to chat_room_path + "?chat_room=#{c.id}"
  end

  def chatting
    @chat_room = ChatRoom.find_by('id = ?',params[:chat_room])
    if(@chat_room.blank?)
      redirect_to '/'

    end
    if(current_user.premission?(params[:chat_room]))
      flash[:notice] = "Premission Denied"
      @chat_room = nil
      redirect_to '/'
  end
end
end
