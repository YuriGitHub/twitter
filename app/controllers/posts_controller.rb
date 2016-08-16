class PostsController < ApplicationController

	def index
		@user = User.find(params[:id])
		@postq = Post.new
	end

	def create
		@user = User.find(params[:id])
		post = Post.new(post_params)
		post.user_id = @user.id
		post.save
		redirect_to :back
	end

	def show
	end

	def destroy
		@user = User.find(params[:id])
		@post = Post.find_by(params[:user_id])
		@post.destroy
	end

	def update
	end

	private
	def post_params
		params.require(:post).permit(:text)
	end
end
