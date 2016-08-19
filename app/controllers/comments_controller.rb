class CommentsController < ApplicationController
	def create
		@comment = Comment.new(comment_params)
		if @comment.save			
			@result = 'sussess'
		else
			@result = 'error'
		end		
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
