$(document).ready(function(){	

	var newCommentForms = $(".new_comment");
	$.each(newCommentForms, function(key, obj){
		$(obj).on("keypress", function(e){
			if(e.which == 13 ){
				$(this).submit();
			}
		});
	});

	//comments to posts
	var arrShowCommentsAreaLinks = $('.show-comments-area-link');
	$.each(arrShowCommentsAreaLinks, function(key, obj){
		$(obj).click(function(e){	
			e.preventDefault();		
			var select = "[id=" + $(this).attr('id') + "]";			
			$(select).filter('.comments-area').toggle();		   
		});
	});	
	
});
