class CommentsController < ApplicationController
	def create		
			@comment = Comment.new(comment_params)
			if @comment.save			
				@result = 'success'
			else
				@result = 'error'
			end	
		else
			
	end


	def reply_comment
		@comment = Comment.find(params[:id])
	end

	def ansver_to_comment
		@comment = Comment.find(params[:id])
		@login = User.find(@comment.user_id).login.split('@')[0]
		@current_login = current_user.login.split('@')[0]
	end


	def destroy
		comment = Comment.find(params[:id])
		@id = comment.id
		comment.destroy
	end

	private

	def comment_params
		params.require(:comment).permit(:user_id, :post_id, :text, :commentable_type, :commentable_id)
	end
end
