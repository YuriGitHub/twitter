class UsersController < ApplicationController
	before_action :authenticate_user!

	def show
	    @user = User.find(params[:id])
	    @post = Post.new
	    @posts = Post.where('user_id = ?', @user.id).page(params[:page]).per(4).reverse_order!
	end 
end
