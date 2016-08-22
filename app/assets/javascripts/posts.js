$(document).ready(function(){

$('#new_post_but').click(function(){
    $('.new_post_form').slideToggle('slow')
});

//new post with AJAX
$("#new_post").on("ajax:success", function(e, data, status, xhr) {
	    var post = JSON.parse(xhr.responseText);		
      $(".post_index").append('<div class="panel panel-default">' +
                             '<div class="panel-body">' +
                             '<h5>Created : ' + post.created_at + '</h5>' +
                             '<h5>--------------------------------------------</h5>'  +
                             '<h5>' + post.text + '</h5>' + '</div>' ); 
       $(".new_post_form").toggle();
    }).on("ajax:error", function(e, xhr, status, error) {
      $("#new_post").append("<p>ERROR</p>");
    });
});


//Destroy with AJAX 
$(document).on('ajax:success', '#del_ps', function() {
    // .parent() is the div containing this "X" delete lin
    $(this).closest(".post").slideUp();
    }
); 
