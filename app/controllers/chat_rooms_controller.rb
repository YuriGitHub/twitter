class ChatRoomsController < ApplicationController

  def find_chat_room
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
