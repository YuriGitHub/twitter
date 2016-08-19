Rails.application.routes.draw do


  devise_for :users, :controllers => { :registrations => "users/registrations" ,:omniauth_callbacks => "users/omniauth_callbacks" }

  devise_for :admin_users, ActiveAdmin::Devise.config

  post "ajax_check_validations", to: 'services#ajax_check_validations'

  ActiveAdmin.routes(self)
  
  root :to => 'home#index'
  get 'home/ifollow'=>'home#ifollow'
   #todo must be post
  get 'home/toggle_follow'=>'home#toggle_follow'

  post 'likes/toggle_like' => 'likes#toggle_like'
  post 'likes/toggle_dislike' => 'likes#toggle_dislike'
  get 'likes/upload_like' => 'likes#upload_like'

  get '/report_to_unlock/', to: 'send_reports#show_report'
  post '/report_to_unlock/:id/', to: 'send_reports#add_report'
  delete '/admin/users/delete_report/:id', to: 'admin/users#delete_report'
  post '/admin/block_user/:id', to: 'admin/users#lock_user'
  post '/admin/unlock_user/:id', to: 'admin/users#unlock_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'search' => 'search#search'
  post 'user/add_report/:id_reportable', to: 'send_reports#add_report_to_user', as: 'send_report'
 
  resources :users, only: [:show] do
    resources :posts, only: [:index, :update, :destroy, :edit, :create]
  end

  resources :comments
  post 'reply_comment/:id' => 'comments#reply_comment', as: :reply_comment
  post 'ansver_to_comment/:id' => 'comments#ansver_to_comment', as: :ansver_to_comment

end
