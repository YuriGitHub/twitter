Rails.application.routes.draw do
 

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users


  get '/report_to_unlock', to: 'send_reports#delete_report'
end
