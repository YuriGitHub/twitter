$(document).ready(function(){	
	//comments to posts
	var arrShowCommentsAreaLinks = $('.show-comments-area-link');
	$.each(arrShowCommentsAreaLinks, function(key, obj){
		$(obj).click(function(e){	
			e.preventDefault();	


			//alert();	
			var select = "[id=" + $(this).attr('id') + "]";			
			$(select).filter('.comments-area').toggle();		   
		});
	});	
	
});
