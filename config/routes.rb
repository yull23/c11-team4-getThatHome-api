Rails.application.routes.draw do

  # get "home/index"
  # root to: "home#index"

  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  post '/users/new' => 'users#create'
  get '/users/' => 'users#show'

  resources :property_user, only: [:index, :show, :create, :destroy]
end
