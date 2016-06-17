Rails.application.routes.draw do

  namespace :api do
    resources :todo_lists do
      resources :todo_items, only: [:index, :show, :create, :update, :destroy]
    end
  end

  get '/login' => 'user_sessions#new', as: :login
  delete '/logout' => 'user_sessions#destroy', as: :logout

  resources :users
  resources :user_sessions, only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :todo_lists do
    resources :todo_items do
      member do
        patch :complete
      end
    end
  end

  root 'todo_lists#index'

end
