Rails.application.routes.draw do
  devise_for :managers

  namespace :backstage do
    resources :managers, only: [:show] do
      resources :restaurants, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy] do
        resources :seats, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy] do
          resources :reservations, shallow: true, only: [:destroy] do
            member do
              patch :mark
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
    end
  end
  
  resources :restaurants, only: [:show] do
    member do
      get :reserve
    end    
  end

  root 'home#index'
end
