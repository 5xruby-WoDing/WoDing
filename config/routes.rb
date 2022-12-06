Rails.application.routes.draw do
  devise_for :managers

  namespace :backstage do
    resources :managers, only: [:show] do
      resources :restaurants, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy]   
    end
    root 'managers#show'
  end

  root 'home#index'
end
