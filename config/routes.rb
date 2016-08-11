Rails.application.routes.draw do
 
  devise_for :users, :controllers => { :registrations => "users/registrations" ,:omniauth_callbacks => "users/omniauth_callbacks", :passwords =>'registrations' }


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)




  get '/report_to_unlock', to: 'send_reports#delete_report'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'search' => 'search#search'

end
