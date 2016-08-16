class PostsController < ApplicationController

	def index
		binding.pry
		@user = User.find(params[:id])
	end
end
