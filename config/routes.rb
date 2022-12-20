Rails.application.routes.draw do
  devise_for :managers

  namespace :backstage do
    resources :managers, only: [:show] do
      resources :restaurants, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy] do
        resources :seats, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy] do
          resources :reservations, shallow: true, only: [] do
            member do
              get :finish
              patch :note
            end
          end
        end
        
      end  
    end
    root 'managers#show'
  end


  resources :users, only: [:create]
  resources :reservations, only: [] do
    member do
      get :checkout
      post :information
      post :reservation_status
    end
  end
  
  resources :restaurants, only: [:show] do
    member do
      post :determine_occupied
      get :reserve
    end    
  end

  root 'home#index'
end
