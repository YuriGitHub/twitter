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


	//comments to comments
	var showCommentDialogLinks = $('.show-comment-dialog-link');
	$.each(showCommentDialogLinks, function(key, obj){
		$(obj).click(function(e){
			e.preventDefault();			
			$('div[data-post-id=' + $(this).attr('data-post-id') + ']' + '[data-comment-id=' + $(this).attr('data-comment-id') + ']').toggle();

		});
	});

	//фенкционал ansver-to-comment-link
	//в textarea соответствующего personal-comment-dialog-area добавить начальный 
	//текст user:current_user.id to user: link/data-user-id: 
	var ansverToCommentLinks = $('.ansver-to-comment-link');
	$.each(ansverToCommentLinks, function(key, obj){
		$(obj).click(function(e){
			e.preventDefault();
			//найти соответств personal-comment-dialog-area
			var dialogArea = $('div[data-post-id=' + $(this).attr('data-post-id') + ']' +
				'[data-comment-id=' + $(this).attr('data-comment-id') + ']');
			var form  = dialogArea.children('form')[0];
			$(form).children('textarea').val('user' + $(this).attr('data-current-user-id') + 
				' to user' + $(this).attr('data-user-id') + ': ');
		});
	});
	
});
