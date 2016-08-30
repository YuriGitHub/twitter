class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    if user_signed_in?
      if params[:locale]
        current_user.locale = params[:locale]
        current_user.save
      else
        if cookies[:locale] and current_user.locale.nil?
          current_user.locale = cookies[:locale]
          current_user.save
        end
      end
    else
      cookies[:locale] = params[:locale] if params[:locale]
    end
    I18n.locale = current_user.try(:locale) || cookies[:locale] || I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:login, :first_name, :last_name, :country, :city, :date_of_birth, :gender, :avatar])
  end

end
