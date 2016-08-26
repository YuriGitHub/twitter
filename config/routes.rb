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
    

    delete 'attachments/:id',to:'attachments#destroy',as:'attachment_destroy'
    resources :users, only: [:show] do
        resources :posts, only: [:index, :update, :destroy, :edit, :create] do
            resources :attachments,only: [:create,:destroy,:update]
        end
    end

    get 'show_image' => 'attachments#show_image'
    get 'show_audios_block' => 'attachments#show_audios_block'
    get 'show_video' => 'attachments#show_video'
    get 'show_videos_block' => 'attachments#show_videos_block'




  
  namespace :api, :defaults => {:format => 'json'} do   
    namespace :v1 do 
      post 'show_profile' =>        'profiles#show'  #http://localhost:3000/api/v1/get_profile?profile[email]=example@gmail.com&profile[token]=example_token
      post 'create_profile' =>    'profiles#create' #{"profile": {"email":"bush@gmail.com", "last_name" : "Bush", "first_name":"George", "login": "bush", "password":"123456"}}
      put 'update_profile' =>     'profiles#update' #{"profile": {"email":"bush@gmail.com", "token":"93a44e76ff35","first_name":"New_first_name", "login": "New_login"}}
      delete 'delete_profile' =>  'profiles#destroy' #{"profile": {"email":"bush@gmail.com", "token":"93a44e76ff35"}} 
      post 'login_profile' =>     'profiles#login'
      post 'logout_profile' =>    'profiles#logout'


      get  'get_post_info' => 'api_posts#show'  #http://localhost:3000/api/v1/get_post_info?post_id=22
      post 'create_post' => 'api_posts#create' #{"post":{ "users_token": "91cc0dae4081", "text":"it is a new Post!", "post_id":22}} 
      put  'update_post' => 'api_posts#update' #{"post":{ "users_token": "91cc0dae4081", "text":"updated text", "post_id":22}} 
      delete 'delete_post' => 'api_posts#destroy' 




    end
  end

end
