Rails.application.routes.draw do
  devise_for :managers

  resources :managers, only: [:show] do
    resources :restaurants, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy]
  end
  
  root 'home#index'
end
