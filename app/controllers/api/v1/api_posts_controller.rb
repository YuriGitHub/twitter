class Api::V1::ApiPostsController < ActionController::API
	respond_to :json
  	before_action :check_token


  

  def show
  	if post = Post.find_by(id: post_params[:id])
  		render json: { text: post.text, id: post.id, user_id: post.user_id }
  	else
  		render json: { error: "Invalid id."}
  	end
  end 

  def create
  	post = Post.new(user_id: @user.id, text: post_params[:text]) 
  	if post.save   	
  		render json:{ post: post }
  	else
  		render json:{ error: "invalid data", post: "Not created" }
  	end
  end 

  def update

  	if post = Post.find_by(id: post_params[:id])

      unless post.user_id == @user.id
        render json: {error: "it's another users post"}
        return
      end

  		if post.update(text: post_params[:text])
  			render json: { post: post }
  		else
  			render json: { error: "Invalid data." }
  		end
  	else
  		render json:{ error: "invalid id" }
  	end
  end

  def destroy
  	if post = Post.find_by(id: post_params[:id])
      unless post.user_id == @user.id
        render json: {error: "it's another users post"}
        return
      end  


  		if post.destroy  			
  			head 204
  		end
  	else
  		render json: { error: "Wrong parameter id."}
  	end
  end





  private
  def post_params    
    params.require(:post).permit(:text, :id)
  end
  def access_params
    params[:access][:token]
  end

  def check_token   
    unless @user = User.find_by_token(:activate, access_params) 
      render json: {error: "wrong token"}
      return false
    end

    if token = @user.tokens.find_by_name(:activate).expires_at < Time.now
      token.destroy
      render json: {error: "wrong token"}
      return false
    end
  end

end