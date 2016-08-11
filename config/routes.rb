Rails.application.routes.draw do

  get '/report_to_unlock', to: 'send_reports#delete_report'

  devise_for :users, :controllers => { :registrations => "users/registrations" ,:omniauth_callbacks => "users/omniauth_callbacks", :passwords =>'registrations' }

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  get 'search' => 'search#search'

end
