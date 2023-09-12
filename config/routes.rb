Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :users, only: [:create, :index] do 
        collection do 
          post :login
          post :deactivate
          get :tasks
        end
      end
    
      resources :task, only: [:create, :index, :update] do 
        collection do 
          post :delete 
          put :update_status
          post :find_by_category
        end
      end
      
      resources :task_category, only: [:create, :index, :update] do 
        collection do 
          delete :delete
        end
      end

      resources :task_comments, only: [:create] do
      end
    end
  end
end
