Rails.application.routes.draw do
    # post 'admin/deactivate_user' => "users#deactivate"
  # post 'admin/create_task' => "task#create"
  # get 'admin/all_users' => "users#list_all"
  # delete 'admin/delete_task' => "task#delete"
  namespace :api do 
    namespace :v1 do 
      post 'register' => "sessions#create"
      post 'login' => "sessions#login"

      resources :users, only: [:index] do 
        collection do 
          post :deactivate
        end
      end
    
      resources :task, only: [:create, :index] do 
        collection do 
          post :delete 
        end
      end
      
      resources :task_category, only: [:index] do 
      end

    end
  end
  

  

end
