
var perform_search;
var toggle_follow;

$(document).ready(function(){
    var user_template = $('#user_template')
    var search_field = $('#search_field')
    var search_button = $('#search_button')
    var users_container = $('#users')
    var last_action;


    toggle_follow = function(id){
        $.get("/home/toggle_follow",{'id': id.split("_")[1]}).then(function(data){
            last_action()
        })
    }
    var upload_followers = function(){
        $.get("home/followers",{}).then(function(data){
            last_action = upload_followers
            resolve_user_data(data)
        })
    }
    var search = function() {
        $.get("/search",{query:search_field.val()}).then(function(data){
                last_action = perform_search
                resolve_user_data(data)
        })
        
    }
    var resolve_user_data = function(data){
        console.log(data)
        users_container.empty()
        for(i in data){

           var template =  user_template.clone()
           var ava =  template.children("#avatar")
           var info = template.children("#title")

           var follow_button = template.children("#follow_button")

           template.attr("id","template_"+data[i].id)
           ava.attr("id","avatar_"+data[i].id)

           if(data[i].image_url != null){
              ava.attr("src",+data[i].id)
           }

           info.attr("id","title_"+data[i].id)
           follow_button.attr("id","followtoggle_"+data[i].id)

           if(data[i].follow == "following")
                follow_button.html('unfollow')
           else
                follow_button.html('follow')


          //update avatar in here 
           info.text(data[i].login)

           users_container.append(template)
           template.css("display",'block')

        }
    }
    perform_search = function(){
        console.log("")
        search(search_field.val())
    }
    upload_followers();
});
