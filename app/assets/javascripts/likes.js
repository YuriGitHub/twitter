
var perform_like;
var perform_dislike;
var upload_like;
$(document).ready(function(){

    var parse_like = function(id,data){
            var c = $("#like-container_"+id)
            likes = c.find('#like_count')
            like = c.find('#like')
            dislikes = c.find('#dislike_count')
            dislike = c.find('#dislike')

            if(data.likes != null && data.dislikes != null){
                likes.html(data.likes)
                dislikes.html(data.dislikes)
            }

            if(data.like == ''){
                like.attr('class','glyphicon glyphicon-thumbs-up like-element')
                dislike.attr('class','glyphicon glyphicon-thumbs-down like-element')
            }

            if(data.like == 'true'){
                like.attr('class','glyphicon glyphicon-thumbs-up liked like-element')
                dislike.attr('class','glyphicon glyphicon-thumbs-down like-element')
            }
 
            if(data.like == 'false'){
                like.attr('class','glyphicon glyphicon-thumbs-up like-element')
                dislike.attr('class','glyphicon glyphicon-thumbs-down disliked like-element')
            }

    }

    perform_like = function(id){
        $.post('/likes/toggle_like',{post_id:id}).then(function(data){
            parse_like(id,data)
        })
    }

    perform_dislike = function(id){
        $.post('/likes/toggle_dislike',{post_id:id}).then(function(data){
            parse_like(id,data)
        })
    }

    upload_like = function(id){
        $.get('/likes/upload_like',{post_id:id}).then(function(data){
            console.log(data)
            parse_like(id,data) 
         });
    }

});
