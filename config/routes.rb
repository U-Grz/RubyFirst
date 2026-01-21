Rails.application.routes.draw do
  resources :products
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :passwords, param: :token
  delete '/logout', to: 'sessions#destroy', as: :logout

  namespace :api do
    namespace :v1 do
      resources :users
      resources :sessions, only: [:create, :destroy]

      get '/health', to: proc { [200, {}, ['OK']] }
    end
  end

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "products#index"
end
