Rails.application.routes.draw do
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
          post :show_all_by_sort
          post :find_by_category
        end
      end
      
      resources :task_category, only: [:index, :update, :create] do 
        collection do 
          delete :delete
        end
      end

      resources :task_comments, only: [:create] do
      end
    end
  end
end
