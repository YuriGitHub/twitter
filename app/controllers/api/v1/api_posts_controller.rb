class Api::V1::ApiPostsController < ActionController::API
	respond_to :json
  	before_action :check_token, except:[:show]


  def check_token   
    unless @user = User.find_by_token(:activate, post_params[:users_token]) 
      render json: {token: 'no correct'}
    end
  end

  def show
  	if post = Post.find_by(id: params[:post_id])
  		render json: { text: post.text, id: post.id, user_id: post.user_id }
  	else
  		render json: { error: "Invalid post_id."}
  	end
  end 

  def create
  	post = Post.new(user_id: @user.id, text: post_params[:text]) 
  	if post.save   	
  		render json:{ post: post.text, created: "Successfully" }
  	else
  		render json:{ error: "invalid data", post: "Not created" }
  	end
  end 

  def update
  	if post = Post.find_by(id: post_params[:post_id])
  		if post.update(text: post_params[:text])
  			render json: { post: post.as_json }
  		else
  			render json: { error: "Invalid data." }
  		end
  	else
  		render json:{ error: "invalid post_id" }
  	end
  end

  def destroy
  	if post = Post.find_by(id: post_params[:post_id])
  		if post.destroy
  			render json: { post: post.as_json, deleted: "successfully" } 
  			head 204
  		end
  	else
  		render json: { error: "Wrong parameter post_id."}
  	end
  end





  private
  def post_params    
    params.require(:post).permit(:users_token, :text, :post_id)
  end
end