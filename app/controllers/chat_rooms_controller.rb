class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def find_chat_room
    check_chat_room
    c = ChatRoom.get_chat_room_by_users_array([current_user.id,params[:user_id].to_i])
    redirect_to chat_room_path + "#chat_room=#{c.id}"
  end

  def chatting
    # check_chat_room
    binding.pry
    # @chat_rooms = ChatRoom.where("users @> ARRAY[?]", current_user.id)
    # @chat_room = ChatRoom.find_by('id = ?',params[:chat_room])
    # if(@chat_room.blank?)
    #   redirect_to '/'
    #   return
    # end
    # if(current_user.premission?(params[:chat_room]))
    #   flash[:notice] = "Premission Denied"
    #   @chat_room = nil
    #   redirect_to '/'
    #   return
  end

end

def find_users
  search = Sunspot.search( User ) do
      fulltext params[:user]
  end
  results = search.results
  render json: results.map { |user| [user.login, user.id]}

end

  def create_chat_room
    users_id = [current_user.id]
    params[:users].each{ |user| users_id.push user.to_i }

    chat_room = ChatRoom.where('users = ARRAY[?]', users_id.sort).first
    if(chat_room)
      render json: {type: 'old', chat_room_id: chat_room.id, messages: chat_room.messages, users: chat_room.users}
    else
      chat_room = ChatRoom.create(users: users_id, title: params[:title], user: current_user)
      render json: {chat_room_id: chat_room.id, type: 'new',users: chat_room.users }
      chat_room.destroy
    end
  end

  private
  def check_chat_room
    c = ChatRoom.get_chat_room_by_users_array([current_user.id,params[:user_id].to_i])
    if c == nil
      c = ChatRoom.new
      c.users = [current_user.id,params[:user_id].to_i]
      c.users.sort
      c.save
    end
  end

end
