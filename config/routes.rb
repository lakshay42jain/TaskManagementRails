Rails.application.routes.draw do
  post 'signup' => "users#signup"
  post 'login' => "sessions#login"
  delete 'logout' => "sessions#logout"
end
