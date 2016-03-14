Rails.application.routes.draw do
  root "links#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete "logout", to: "sessions#delete"
  resources :users, only: [:new, :create]
  resources :links, only: [:index, :create, :update, :edit, :destroy]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
end
