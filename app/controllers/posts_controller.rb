class PostsController < ApplicationController
	before_action :authenticate_user!

	def index
		# binding.pry
		@user = User.find(params[:id])
		@posts = @user.posts
	end

	def create
		@user = User.find_by(params[:id])
		@post = Post.new(post_params)
		@post.user_id = @user.id
		# binding.pry
		@post.save
		respond_to do |format|
      if @post.save
        format.html { redirect_to current_user }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to current_user, notice: "Post not created :(" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def destroy
		post = Post.find(params[:id])
		post.destroy
		respond_to do |format|
			format.html { redirect_to current_user }
      format.json { head :no_content }
		end
	end

	def update
		user = User.find(params[:user_id])
		post = Post.find(params[:id])
		post.update(post_params)
		respond_to do |format|
      if @post.update(car_params)
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
