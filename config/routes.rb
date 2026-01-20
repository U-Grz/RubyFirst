Rails.application.routes.draw do
  resources :products
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :passwords, param: :token
  delete '/logout', to: 'sessions#destroy', as: :logout
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "products#index"
end
