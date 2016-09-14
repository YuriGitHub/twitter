var user_id;

function connecting(id_chat_room) {

    App.global_chat = App.cable.subscriptions.create({
        channel: "ChatsChannel",
        id: id_chat_room,

    }, {
        connected: function() {
            console.log('connected')
        },
        disconnected: function() {
            console.log('unsubscribed');

        },
        received: function(data) {
            $('#insert_message').append(text_for_append(data));
            console.log(data);
            $("#text_value").val('');
            var objDiv = document.getElementById("scroll");
            objDiv.scrollTop = objDiv.scrollHeight;
            console.log('here');
        },
    });
}
var obj = {
    image: '',
    login: 'undefined',
    message: 'NONE',
    user_id: 'none',
    layout: 'left',
    set data(data) {
        this.image = data.image;
        this.login = data.login;
        this.user_id = data.user_id;
        this.message = data.message;
        if (data.user_id != user_id) {
            this.layout = 'left';
        } else {
            this.layout = 'right';
        }

    }

}

function get_user_id() {
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


$("#submit").click(function() {
    sen()
});
$("#text_value").keypress(function(e) {
    if (e.which == 13) {
        sen()
    }
});

function sen() {
    var text_message = $("#text_value").val();
    App.global_chat.perform("send_message", {
        text: text_message
    });
}






function text_for_append(data) {
    obj.data = data;

    return "<div class='answer" + obj.layout + ">"+
                "<div class='avatar'>"+
                  "<img src=" + obj.image + " alt='User name'>"+
                  "<div class='status offline'></div>" +
                "</div>"+
                "<div class='name'>" + obj.login + "</div>"+
                "<div class='text'>"+obj.message +" </div>" +
                "<div class='time'>5 min ago</div> </div>"
}

var t;

function get_all_chat_rooms() {
    $.ajax({
        url: 'get_all_chat_rooms',
        method: 'get',
        data: '',
        success: function(data) {
            data.forEach(function(current) {
                $('.chat-users').append(show_chat_rooms(current))
            })
            add_onclik();
        }

    })
}

function add_onclik() {

    $(".user").click(function() {
        console.log("lalalalala");
        create_loader();
        App.global_chat.unsubscribe();
        t = this;
        document.location.hash = "chat_room=".concat(t.dataset.idChatRoom)
        change_chat_room();
    });
}

function create_loader() {
    $('.chat-body').prepend("<div id='loader'></div>");
    $('.chat-body').addClass('no_display');
}

function show_chat_rooms(data) {
    var on;
    if (data.status) {
        on = 'online'
    } else {
        on = 'offline'
    }
    return "<div class='user' data-id-chat-room=" + data.id + ">" +
                    "<div class='avatar>"+
                    "<img src=" + data.image + " alt='User name' width='40' height='40'>" +
                    "<div class='status " + on + "'></div>"+
                    "</div>"+
                    "<div class='name'>" + data.title + "</div>" +
                "</div>"
}
