class ServicesController < ApplicationController
	def ajax_check_validations
		new_login = params[:new_login]
		
   		if User.find_by(login: new_login) && new_login != current_user.login
   			render json:{'result' => 'login exists'}
   		else
   			render json:{'result' => 'success'}
   		end   		
    end
end
