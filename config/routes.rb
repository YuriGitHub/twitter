Rails.application.routes.draw do
 
devise_for :users, :controllers => {:registrations => "users/registrations"}

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'search' => 'search#search'
end
