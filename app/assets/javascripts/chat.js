


var user_id;

var obj = {
  image: '',
  login: 'undefined',
  message: 'NONE',
  user_id: 'none',
  layout: 'left',
  set data(data){
    this.image = data.image;
    this.login = data.login;
    this.user_id = data.user_id;
    this.message = data.message;
    if(data.user_id != user_id){
      this.layout = 'left';
    }
    else {
      this.layout = 'right';
    }

  }

}

function get_user_id(){
  user_id = $("#user_id").val();
}
function getParameterByName(name) {
    url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
App.global_chat = App.cable.subscriptions.create({
  channel: "ChatsChannel",
  id: document.location.hash.split('=')[1],

}, {
  connected: function() {
    console.log('connected')
  },
  disconnected: function() {},
  received: function(data) {
    $('#insert_message').append(text_for_append(data));
    console.log(data);
    $("#text_value").val('');
    var objDiv = document.getElementById("scroll");
objDiv.scrollTop = objDiv.scrollHeight;
    console.log('here');
  },
});

$( "#submit" ).click(function() {
sen()
});
$("#text_value").keypress(function(e){
    if(e.which == 13){
        sen()
    }
});
function sen(){
  var text_message = $("#text_value").val();
  App.global_chat.perform("send_message",{text: text_message});
}
$( ".user" ).click(function() {
  var obj = jQuery(this).children();
  obj = obj[2]['outerText'];
  console.log(obj);
});




function text_for_append (data){
obj.data = data;

return `<div class="answer ${obj.layout}">
                <div class="avatar">
                  <img src="${obj.image}" alt="User name">
                  <div class="status offline"></div>
                </div>
                <div class="name">${obj.login}</div>
                <div class="text">
                ${obj.message}
                </div>
                <div class="time">5 min ago</div>
              </div>`
}


function get_all_chat_rooms(){

  $.ajax({
    url: 'get_all_chat_rooms',
    method: 'get',
    data: '',
    success: function(data){
      console.log(data)
    }

  })
}
