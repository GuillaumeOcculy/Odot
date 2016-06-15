Rails.application.routes.draw do

  resources :user_sessions, only: [:new, :create]

  resources :users
  root 'todo_lists#index'

  resources :todo_lists do
    resources :todo_items do
      member do
        patch :complete
      end
    end
  end


end
