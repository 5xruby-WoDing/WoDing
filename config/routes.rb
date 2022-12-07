Rails.application.routes.draw do
  devise_for :managers

  namespace :backstage do
    resources :managers, only: [:show] do
      resources :restaurants, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy] do
        resources :seats, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy]
      end  
    end
    root 'managers#show'
  end
  
  resources :restaurants, only: [:show] 

  root 'home#index'
end
