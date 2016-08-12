Rails.application.routes.draw do
 

devise_for :users, :controllers => {:registrations => "users/registrations"}

  devise_for :users, :controllers => { :registrations => "users/registrations" ,:omniauth_callbacks => "users/omniauth_callbacks", :passwords =>'registrations' }

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  
  root :to => 'home#index'
  get 'home/followers'=>'home#followers'
  get 'home/toggle_follow'=>'home#toggle_follow'

  get '/report_to_unlock/', to: 'send_reports#show_report'
  post '/report_to_unlock/:id/', to: 'send_reports#add_report'
  delete '/admin/users/delete_report/:id', to: 'admin/users#delete_report'
  post '/admin/block_user/:id', to: 'admin/users#lock_user'
  post '/admin/unlock_user/:id', to: 'admin/users#unlock_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'search' => 'search#search'

end
