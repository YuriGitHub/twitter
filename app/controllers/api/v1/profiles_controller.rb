class Api::V1::ProfilesController < ActionController::API
  respond_to :json
  before_action :check_token, except: [:create]


  def check_token
    token = params[:token]    
    user = User.find_by(email: request_params[:email])
    token = user.tokens.find_by(name:'activate')
    if token.token != request_params[:token] 
      render json: {token: 'no correct'}
    end
  end  

  def show      
    respond_with User.find_by(email: request_params[:email])    
  end

  def create
   	user = User.new(profile_params) 
        # if the user is saved successfully than respond with json data and status code 201
   	if user.save 
      token = user.add_token(:activate, expires_at: 10.years.from_now)
    	render json: {token: token.token}, status: 201
   	else
    	render json: { errors: user.errors}, status: 422
   	end
  end

  def update
    user = User.find_by(email: request_params[:email])

    if user.update(profile_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

 def destroy
    user = User.find_by(email: request_params[:email])
    user.destroy
    head 204
  end

  private
  def profile_params   
   	params.require(:profile).permit(:email, :password, :password_confirmation, :login, :first_name, :last_name, :date_of_birth) 
  end

  def request_params    
    params.require(:profile).permit(:email, :token)
  end

  
end  