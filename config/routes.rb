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


  resources :users, only: [:create]
  resources :reservations, only: [] do
    member do
      get :checkout

      # 這個是給店家老闆按的路徑，按下去訂單會打開
      get :finish
    end
  end
  
  resources :restaurants, only: [:show] do
    member do
      get :reserve

    end    
  end

  root 'home#index'
end
