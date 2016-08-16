class UsersController < ApplicationController
	before_action :authenticate_user!

	def show
	    @user = User.find(params[:id])
            @is_following = false
            if current_user != nil
                @is_following = true if current_user.ifollow.find_by_id(@user.id) != nil
            end
	end 
end
