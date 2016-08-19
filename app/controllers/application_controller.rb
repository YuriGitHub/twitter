class ApplicationController < ActionController::Base

  before_action :set_locale
  
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    if user_signed_in? and params[:locale]
        current_user.locale = params[:locale]
        current_user.save
     # I18n.locale = current_user.try(:locale) || I18n.default_locale
    else
      session[:locale] = params[:locale] if params[:locale]
     # I18n.locale = session[:locale] || I18n.default_locale
    end
    I18n.locale = current_user.try(:locale) || session[:locale] || I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:login, :first_name, :last_name, :country, :city, :date_of_birth, :gender, :avatar])
  end

end
