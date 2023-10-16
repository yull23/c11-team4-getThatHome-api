Rails.application.routes.draw do
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"
  
  # post '/users' => 'users#create'
  # get '/users/' => 'users#show'
  resources :users, only: %i[create show]
  # resources :profile, only: [:show]
  # resources :property_user, only: %i[index show create destroy]
  # get "home/index"
  # resources :property_types, only: %i[index]
  # post "/properties", to:"properties#create"
  # get "/properties/:id", to:"properties#show"
  # put "/properties/:id", to:"properties#update"
  # resources :properties, only: %i[index show create update destroy]
end
