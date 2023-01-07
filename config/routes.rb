# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get '/welcome' => 'home#after_registratioin_path'
  devise_for :managers, :controllers => { registrations: 'managers/registrations' }

  namespace :backstage do
    resources :managers, only: [:show] do
      resources :restaurants, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy] do
        resources :reservations, shallow: true, only: [:index] do
          member do
            get :cancel
            get :complete
            patch :note
            get :qrscan
          end
          collection do
            post :statistics
            get :history  
          end
        end
        resources :opening_times, shallow: true, only: [:index, :create, :edit, :update, :destroy]
        resources :off_days, shallow: true, only: [:create, :destroy]
        resources :seats, shallow: true, only: [:index, :create, :edit, :update, :destroy] do
          member do
            get :vacant
            get :occupied
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
      post :notify
      post :reservation_status
      get :cancel
      get :cancelled
    end
  end

  resources :restaurants, only: [:show] do
    collection do
      get :waring
    end
    member do
      post :occupied
      get :reserve 
      post :out
    end
  end

end
