Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    collection do
      get :feeds
      get :ranking
      get :about
    end

    member do
      get :dashboard
      post :favorite
      post :unfavorite
      post :like
      post :unlike
    end
    
  end
  resources :categories, only: :show

  resources :users, only: [:index, :show, :edit, :update] do

    member do
      get :friend_list
    end

  end

  resources :followships, only: [:create, :destroy]

  resources :friendships, only: [:create, :destroy]

  root "restaurants#index"

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end
  
end
