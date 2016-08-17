class HomeController < ApplicationController
    before_action :authenticate_user!
    def index
        @query = params[:query]
    end

    def toggle_follow
        respond_to do |format|
            format.json{
                u = User.find(params[:id])
                if u != nil
                    if current_user.ifollow.find_by_id(u.id) == nil
                        current_user.ifollow << u
                        render json: {}
                    else
                        current_user.ifollow.delete(u)
                        render json: {}
                    end
                else
                    render json: {}, status: 400
                end
            }
            format.html{
                u = User.find(params[:id])
                if u != nil
                    if current_user.ifollow.find_by_id(u.id) == nil
                        current_user.ifollow << u
                    else
                        current_user.ifollow.delete(u)
                    end
                end

                redirect_to :back 
            }
        end
    end

    def ifollow
        respond_to do |format|
            format.json{
                ifollow = current_user.ifollow
                ifollow.each do |u|
                    u.is_follower = 'following'
                end
                render json: ifollow}
        end
    end

    def posts
        # TODO speed2
    end
end
