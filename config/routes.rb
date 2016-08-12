Rails.application.routes.draw do
 

devise_for :users, :controllers => {:registrations => "users/registrations"}

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root :to => 'home#index'
  get 'home/followers'=>'home#followers'
  get 'home/toggle_follow'=>'home#toggle_follow'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'search' => 'search#search'
end
