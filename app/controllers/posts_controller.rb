class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
        @user = User.find(params[:id])
        @posts = @user.posts
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id

        if @post.save
            respond_to do |format|
                format.json {render json: @post.as_json, status: 200 }
                format.html { redirect_to current_user }
            end
        end
    end

    def edit
        @post = Post.find(params[:id])
        #@image = Image.create(post_id:@post.id)
        @attachment = Attachment.new
        
    end

    def destroy
        post = Post.find(params[:id])
        respond_to do |format|
            if post.destroy
                format.json {render json: @post.as_json, status: 200 }
                format.html { redirect_to current_user }
            end
        end
    end

    def update
        user = User.find(params[:user_id])
        @post = Post.find(params[:id])
        respond_to do |format|
            if @post.update(post_params)
                format.html { redirect_to current_user }
                format.json { render :show, status: :ok, location: @post }
            else
                format.html { render :edit }
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

    private
    def post_params
        params.require(:post).permit(:text)
    end
end
