class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def find_chat_room
    check_chat_room
    c = ChatRoom.get_chat_room_by_users_array([current_user.id,params[:user_id].to_i].sort)
    binding.pry
    redirect_to chat_room_path + "#chat_room=#{c.id}"
  end

  def chatting
    # check_chat_room

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
  # end

end

def find_users
  search = Sunspot.search( User ) do
      fulltext params[:user]
      without(:id, current_user.id)
  end
  results = search.results
  render json: results.map { |user| [user.login, user.id]}

end
#
# this.image = data.image;
# this.login = data.login;
# this.user_id = data.user_id;
# this.message = data.message;
def get_chat_room_data
  messages = ChatRoom.find(params[:chat_room_id]).messages
  
    render json: messages.map{|m| {image: m.user.avatar(:thumb), login: m.user.email, user_id: m.user.id, message: m.text_message}}

end


  def get_all_chat_rooms

    chat_rooms = ChatRoom.where('users @> ARRAY[?]',current_user.id)
    res = Array.new
    chat_rooms.each do |c|
      id = c.id
        title = c.is_chat_room? ? c.title : c.get_another_user_from_chat_room(current_user).email
        image = c.is_chat_room? ? 'chat.jpg' : c.get_another_user_from_chat_room(current_user).avatar(:thumb)
        status = c.is_chat_room? ? false : c.get_another_user_from_chat_room(current_user).is_online?
        res.push ({title: title, image: image, status: status, id: id})
    end
    render json: res
  end


  def create_chat_room
    users_id = [current_user.id]
    params[:users].each{ |user| users_id.push user.to_i }
    chat_room = ChatRoom.create(users: users_id.sort, title: params[:title], user: current_user)
    render json: {title: chat_room.title, image: 'chat.jpg', status: 'offline', id: chat_room.id}
    end

  private
  def check_chat_room
    c = ChatRoom.get_chat_room_by_users_array([current_user.id,params[:user_id].to_i])
    binding.pry
    if c == nil
      c = ChatRoom.new
      c.users = [current_user.id,params[:user_id].to_i].sort
      c.save
    end
  end

end
