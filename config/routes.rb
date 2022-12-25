# frozen_string_literal: true

Rails.application.routes.draw do
  get 'messages/create'
  devise_for :managers

  namespace :backstage do
    resources :managers, only: [:show] do
      resources :restaurants, shallow: true, only: [:new, :create, :show, :edit, :update, :destroy] do
        post :selector
        resources :opening_times, shallow: true, only: [:new, :create, :edit, :update, :destroy]
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
      post :notify
      post :reservation_status
      get :cancel
    end
  end

  resources :restaurants, only: [:show] do
    member do
      post :occupied
      get :reserve 
      post :timeout
    end
  end

  root 'home#index'
end
