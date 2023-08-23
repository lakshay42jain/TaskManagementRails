Rails.application.routes.draw do
  post 'signup' => "users#signup"
  post 'login' => "sessions#login"
  delete 'logout' => "sessions#logout"
  post 'deactivate_user' => "users#deactivate_user"

  post 'create_task' => "task#create"
  
end
