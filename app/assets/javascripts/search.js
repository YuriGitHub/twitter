var user_show_page = 'user_show'
var user_search_page = 'search'
var toggle_follow;

$(document).ready(function(){

    var search_field = $('#search_field')
    var search_button = $('#search_button')
    var results_modal = $('#results')
    var search_type = $('#search-type')
    var search_window = $('#result-window')
    var modal_data;

    if(typeof page != 'string'){
        page = ""
    }
    console.log(page)

    if(page == user_search_page){
        var users_container = $('#users')
        var user_template = $('#user_template')
    }


    var search_modal = function(data){
        modal_data = data
        results_modal.empty()
        search_window.css('visibility','visible')
        if(search_type.prop('checked') == true)
            resolve_mini_user_data(data)
    }

    toggle_follow = function(id){
        $.get("/users/toggle_follow",{'id': id.split("_")[1]}).then(function(data){
            search()
        })
    }

    var resolve_mini_user_data = function(data){
        mini_user_template = $('#user-mini-template')
        console.log(mini_user_template)
        var cutted = false;

        if( data.length > 5) {
            data = data.slice(0,5)
            cutted = true;
        }
        var template = null;
        for (i in data) {
            template = mini_user_template.clone()
            avatar = template.find('#avatar')
            info = template.find('#title')
            refs = template.find('.user_ref').get()
            if((data[i].first_name != null && data[i].last_name != null ))
                info.text(data[i].login+" ("+data[i].first_name+" "+data[i].last_name+")")
            else
                info.text(data[i].login+""+(data[i].first_name != null ? ", "+data[i].first_name: "")+(data[i].last_name != null ? " "+data[i].last_name: ""))
            avatar.attr("href","/users/"+data[i].id)

            avatar.attr("src","/"+data[i].image_url)

            for(ref in refs){
                $(refs[ref]).attr("href","/users/"+data[i].id)
            }
            results_modal.append(template)
            template.css("display","block")
        }
        if (cutted) {
            template.append('<li class="pull-right search-link"><a href="/users/search?query='+search_field.val()+'"><b>All results</b></li>')
        }else{
            if(template != null)
                template.append('<li class="pull-right search-link"><a href="/users/search?query='+search_field.val()+'">Advanced search</li>')
            else
                results_modal.append('<li class="search-link"><a href="/users/search?query='+search_field.val()+'"><h4>Advanced search</h4></li>')
        }
    }

    var resolve_user_data = function(data){
        users_container.empty()
        for(i in data){

            var template =  user_template.clone()
            var ava =  template.find("#avatar")
            var info = template.find("#title")
            var refs = template.find('.user_ref').get()

            var follow_button = template.find("#follow_button")

            template.attr("id","template_"+data[i].id)
            ava.attr("id","avatar_"+data[i].id)
            ava.attr("src","/"+data[i].image_url)


            info.attr("id","title_"+data[i].id)
            follow_button.attr("id","followtoggle_"+data[i].id)

            if(data[i].follow == "following"){
                follow_button.html('unfollow')
                follow_button.attr("class","btn btn-sm btn-danger")
            }
            else {
                follow_button.html('follow')
                follow_button.attr("class","btn btn-sm btn-success")
            }

            for(ref in refs){
                $(refs[ref]).attr("href","/users/"+data[i].id)
            }

            //update avatar in here 
            info.text(data[i].login)

            users_container.append(template)
            template.css("display",'block')

        }
    }


    //-----------Search--logic
    var search = function() {
        var url;
        if(search_type.prop('checked') == true)
            url = "/search/users"
        else
            window.location.replace('/?query='+search_field.val())
        $.get(url,{query:search_field.val()}).then(function(data){
            console.log(data)
            var is_search = false;
            //if(page == user_show_page && search_type.prop('checked') == false){
            //resolve_post_data(data)
            //is_search = true
            //}

            if(page == user_search_page && search_type.prop('checked') == true ){
                resolve_user_data(data)
                is_search = true
            }

            if(!is_search)
                search_modal(data)
        })}
    //-----------Search--logic



    //-----------Search--keypress
    search_field.keypress(function(e){
        if(e.which == 13){
            search()
        }

    });
    var searching = false;
    search_field.keyup(function(){
        if((search_type.prop('checked') == true) && !searching){
            searching = true;
            setTimeout(function(){
                search();
                searching = false;
            },400);}
    })
    //-----------Search--keypress

    search_field.focusout(function(){
        setTimeout(function(){
            search_window.css('visibility','hidden')
        },200)
    }); 
    search_field.focus(function(){
        if(modal_data != null){

            search_window.css('visibility','visible')
        }
    })


    if(page == user_search_page && (search_field.val() != null && search_field.val() != "")){
        search();
    }
    if(page == user_show_page && (search_field.val() != null && search_field.val() != "")){
        search_type.bootstrapSwitch('state',false);
    }
});
