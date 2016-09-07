class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
        @user = User.find(params[:id])
        @posts = @user.posts
        @posts.each do |post|
            post.set_attachments
        end
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        @post.text = 'New post' if @post.text == nil
        if @post.save
            respond_to do |format|
                format.json {render json: @post,status: :created}
                format.html { redirect_to edit_user_post_path(current_user,@post)}
            end
        end
    end


    def edit
        @post = Post.find(params[:id])
        @post.set_attachments
        @attachment = Attachment.new
    end

    def destroy
        post = Post.find(params[:id])
        respond_to do |format|
            if post.destroy
                format.json {render json: @post, status: 200 }
                format.html { redirect_to current_user }
            end
        end
    end

    def update
        #user = User.find(params[:user_id])
        @post = Post.find(params[:id])
        respond_to do |format|
            if @post.update(post_params)
                format.json { render json: @post, status: :ok }
                format.html { redirect_to current_user }
            else
                format.html { render :edit }
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

    private
    def post_params
        params.require(:post).permit(:text,:header)
    end
end
