class HomeController < ApplicationController

  def index
    
  end

  def toggle_follow
    respond_to do |format|
        format.json{
          u = User.find(params[:id])
        if u != nil
            if current_user.followers.find_by_id(u.id) == nil
                current_user.followers << u
                render json: {} 
            else
                current_user.followers.delete(u)
                render json: {}
            end
        else
            render json: {}, status: 400
        end
        }
    end
  end

  def followers
    respond_to do |format|
        format.json{
         followers = current_user.followers
         followers.each do |u|
                    u.is_follower = 'following'
         end
            render json: followers}
    end
  end

  def posts
# TODO speed2
  end
end
