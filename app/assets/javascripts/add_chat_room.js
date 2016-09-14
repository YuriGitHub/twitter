//
//= require selectize
//


var obj_new_messages
var availableTags = {"item": "val"}
// initialize the Selectize control
var $select = $('#tags').selectize({
  plugins: ['remove_button','restore_on_backspace'],
    delimiter: ',',
    persist: false,
    create: function(input) {
        return {
            value: input,
            text: input
        }
    }
});

$("#create_button").click( function(){
  console.log('creating');
  create_chat_room({users: $('#tags').val().split(','), title: $('#title_chat_room').val()})
});
// fetch the instance
var selectize = $select[0].selectize;

selectize.on('type', function(val){
  find_users(val);
});

selectize.on('focus', function(val){
  find_users(val);
});
var res;
function find_users(val){
  var user = $("#tags").val();

  $.ajax({
    url: '/chat/search',
    method: 'get',
    data: {"user": val },
    success: function(data){
      data.forEach(function(current_value){
        console.log(current_value[0],current_value[1])
        selectize.addOption({value: current_value[1],text: current_value[0]})
      })

    }
  })
};

function get_chat_room(id_chat_room){
  $.ajax({
    url: '/get_chat_room_data',
    method: 'get',
    data: {chat_room_id: id_chat_room},
    success: function(data){
      data.forEach(function(current_value){

        $('#insert_message').append(text_for_append(current_value));
      })
      $("#loader").remove();
      $(".no_display").removeClass('no_display')
      console.log('continue chat room')
      $('.chat').scrollTop(1E10);
    }
  })

}

function create_chat_room(data){
  $.ajax({
    url: '/create_chat_room',
    method: 'post',
    data: {users: data.users, title: data.title},
    success: function(data){
      $('#users_list').after(show_chat_rooms(data));

      add_onclik();
    }
  })
}

function change_chat_room(data){

  $("#insert_message").empty();
  get_chat_room(document.location.hash.split('=')[1]);
  connecting(document.location.hash.split('=')[1]);
}

function change_messages(data){
  if(getParameterByName('chat_room') == data.chat_room_id){
    return;
  }
  window.location.search = jQuery.query.set("chat_room", data.chat_room_id);
  $("#messages_for_del").empty();
  text_for_old_chat_room(data);

}
function text_for_old_chat_room(data){
      var html = '';
      data.messages.forEach(function(current){
        html += "<div class='answer left'>"+
                        "<div class='avatar'>"+
                          "<img src='/' alt='User name'>"+
                          "<div class='status offline'></div>"+
                        "</div>"+
                        "<div class='name'>test</div>"+
                        "<div class='text'>"+current.text_message+ " </div>  <div class='time'>5 min ago</div>"+
                      "</div>";
      });

$("#messages_for_del").append(html);
}
