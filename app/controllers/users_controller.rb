class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
        if params[:query] != nil
            redirect_to root_path+"?query="+params[:query]
        else
            if params[:id] == current_user.id.to_s
                redirect_to root_path
            else
                @user = User.find(params[:id])
                @is_following = false
                if current_user != nil
                    @is_following = true if current_user.ifollow.find_by_id(@user.id) != nil
                end
                @post = Post.new
                @posts = Post.where('user_id = ?', @user.id).page(params[:page]).per(4).reverse_order!
            end
        end
    end

    def feed
        @user = current_user
        @query = params[:query]
        @form_dummy = Post.new(:id => 0)
        @attachment = Attachment.new
        @post = Post.new
        search = nil;
        if @query != nil
            search = Sunspot.search( Post ) do
                fulltext params[:query]
            end
        end
        @posts = search.results if search != nil
        @posts = @user.posts.page(params[:page]).per(5).reverse_order! if @posts == nil
        render 'users/show'
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
    def search
        @query = params[:query] if params[:query]
    end
end
