Rails.application.routes.draw do
  get 'locales/:locale', to: "locales#switch", as: :locales
    devise_for :users, :controllers => { :registrations => "users/registrations" ,:omniauth_callbacks => "users/omniauth_callbacks" }

    devise_for :admin_users, ActiveAdmin::Devise.config

    post "ajax_check_validations", to: 'services#ajax_check_validations'

    ActiveAdmin.routes(self)

    get 'users/ifollow'=>'users#ifollow'
    #todo must be post
    get 'users/toggle_follow'=>'users#toggle_follow'
    get 'users/search' => 'users#search'


    post 'likes/toggle_like' => 'likes#toggle_like'
    post 'likes/toggle_dislike' => 'likes#toggle_dislike'
    get 'likes/upload_like' => 'likes#upload_like'

    get '/report_to_unlock/', to: 'send_reports#show_report'
    post '/report_to_unlock/:id/', to: 'send_reports#add_report'
    delete '/admin/users/delete_report/:id', to: 'admin/users#delete_report'
    post '/admin/block_user/:id', to: 'admin/users#lock_user'
    post '/admin/unlock_user/:id', to: 'admin/users#unlock_user'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get 'search/users' => 'search#search_users'
    get 'search/posts' => 'search#search_posts'
    post 'user/add_report/:id_reportable', to: 'send_reports#add_report_to_user', as: 'send_report'

    root to: "users#feed"

    resources :users, only: [:show] do
        resources :posts, only: [:index, :update, :destroy, :edit, :create]
    end

  resources :users, only:[] do
    resources :photo_albums
    post 'add_photo_to_album/(:format)' => 'photo_albums#add_photo_to_album', as: :add_photo_to_album
    resources :video_catalogs
    post 'add_video_to_catalog/(:format)' => 'video_catalogs#add_video_to_catalog', as: :add_video_to_catalog
    delete 'remove_video' => 'video_catalogs#remove_video', as: :remove_video
  end

    resources :comments
    post 'reply_comment/:id' => 'comments#reply_comment', as: :reply_comment
    post 'ansver_to_comment/:id' => 'comments#ansver_to_comment', as: :ansver_to_comment
    get 'show_comments_area/:id' => 'comments#show_comments_area', as: :show_comments_area



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


    get 'find_chat_room', to: 'chat_rooms#find_chat_room'
    get 'chat_room', to: 'chat_rooms#chatting'

    mount ActionCable.server => "/chats"





  namespace :api, :defaults => {:format => 'json'} do
    namespace :v1 do
      post 'show_profile' =>      'profiles#show'  #{ "email":"test@gmail.com", "token": "4ce99b39f44b"}
      post 'create_profile' =>    'profiles#create' #{"profile": {"email":"test@gmail.com", "last_name" : "Bush", "first_name":"George", "login": "test", "password":"123456"}}
      put 'update_profile' =>     'profiles#update' #{"profile": {"email":"test@gmail.com", "first_name":"New_first_name", "login": "New_login"}, "access": {"token": "c8c71db4d8c3"}}
      delete 'delete_profile' =>  'profiles#destroy' #{"email":"test@gmail.com", "access": {"token": "c8c71db4d8c3"}}
      post 'login_profile' =>     'profiles#login'  #{"email":"test@gmail.com", "password":"123456"}
      post 'logout_profile' =>    'profiles#logout' # {  "email":"test1@gmail.com" , "token": "13f866d2c125"}


      post  'show_post' => 'api_posts#show'  #{"post":{"post_id":26}, "access":{"token":"a93ab139d464"}}
      post 'create_post' => 'api_posts#create' #{"post":{ "text":"it is a new Post!"}, "access":{"token" : "dsnkj778djhg"}}
      put  'update_post' => 'api_posts#update' #{"post":{"text":"hello1Updated Post", "post_id": 27}, "access":{"token":"a93ab139d464"}}
      delete 'delete_post' => 'api_posts#destroy' #{"post":{"post_id": 28}, "access":{"token": "a93ab139d464"}}




    end
  end


end
