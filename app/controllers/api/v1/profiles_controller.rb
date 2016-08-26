class Api::V1::ProfilesController < ActionController::API
  respond_to :json
  before_action :find_user_by_email, except:[:create, :update]  


  def login
    unless @user 
        render json: { error: "Wrong email."}
        return
    else
        unless @user.valid_password?(params[:password])
          render json: { error: "Wrong password" }
          return
        end
        unless @user.tokens.any?
          @user.add_token(:activate, expires_at: 24.hours.from_now)
        end
        token = @user.tokens.find_by(name: 'activate')
        render json: {token: token.token } 
    end    
  end 


  def logout
    #user = User.find_by_email(params[:email])
    #render json: {user: user}
    if check_token(params[:token], @user)
      @user.tokens.find_by(name: 'activate').destroy
      render json: { logout: 'successfully' }
    else
      render json: { error: "wrong token" }
    end
  end


  def show 
     if check_token(params[:token], @user) 
        respond_with @user
     else
        render json: {error: "wrong token"}
     end     
  end

  def create
   	user = User.new(profile_params) 
        # if the user is saved successfully than respond with json data and status code 201
   	if user.save 
      token = user.add_token(:activate, expires_at: 24.hours.from_now)
    	render json: {token: token.token}, status: 201
   	else
    	render json: { errors: user.errors}, status: 422
   	end
  end

  def update     
    find_user_by_email(profile_params[:email])    
    if check_token(access_token, @user)
          if  @user.update(profile_params)  
              render json:{ user: @user }
          else
              render json: {error: "user not updated"} 
          end     
    else
      render json: {error: "wrong token"}
    end
  end

  def destroy
    if check_token(access_token, @user)
      (head 204) ? @user.destroy : (render json: { error: "Profile not deleted."} ) 
    else
      render json: {error: "wrong token"} 
    end
  end




  private

  def profile_params     
   	params.require(:profile).permit(:email, :password, :password_confirmation, :login, :first_name, :last_name, :date_of_birth) 
  end 

  def access_token    
    params.require(:access).permit(:token)[:token]
  end 

  def find_user_by_email(email = nil)
    if email == nil
      email = params[:email]
    end
    @user = User.find_by_email(email) 
  end

  def check_token(token, user)
    if user.tokens.any?
       unless token == user.tokens.find_by_name(:activate).token          
          return false
       end
    else
        return false
    end
    token   
  end 

  
end  