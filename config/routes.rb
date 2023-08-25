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
          get :tasks
        end
      end
    
      resources :task, only: [:create, :index, :update] do 
        collection do 
          post :delete 
          put :update_status
        end
      end
      
      resources :task_category, only: [:index] do 
        collection do 
          delete :delete
        end
      end
    end
  end
  

  

end
