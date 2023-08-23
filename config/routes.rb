Rails.application.routes.draw do
  post 'register' => "users#signup"
  post 'login' => "sessions#login"
  delete 'logout' => "sessions#logout"
  post 'admin/deactivate_user' => "users#deactivate_user"

  post 'admin/create_task' => "task#create"
  get 'admin/all_users' => "users#all_users"
  
end
