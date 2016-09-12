module ChatRoomsHelper

  def is_tet_a_tet_chatroom?(chat_room)
    if chat_room.users.length == 2
      return true
    else
      return false
    end
  end


  def get_another_user_from_chat_room(chat_room)
    users = chat_room.users
    users.each do |u|
      if u != current_user.id
        return User.find(u)
      end
    end
  end


  def set_users_status(user)

    if(user.is_online?)
      # return cdata_section "<div class='answer left'>"
      return content_tag(:div, nil,class: ['status','online'])
    else
      return  content_tag(:div, nil,class: ['status','offline'])
    end
  end




  def loyout_mesage_by_message(message)
    if message.user != current_user
      # return cdata_section "<div class='answer left'>"
      return  tag(:div, class: 'answer left')
    else
      return  tag(:div,class: 'answer right')
    end
  end
end
