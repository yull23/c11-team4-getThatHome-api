Rails.application.routes.draw do
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  resources :users, only: %i[create show]
  # resources :profile, only: [:show]
  # resources :property_user, only: %i[index show create destroy]
  # resources :property_types, only: %i[index]
  # post "/properties", to:"properties#create"
  # get "/properties/:id", to:"properties#show"
  # put "/properties/:id", to:"properties#update"
  resources :properties
  resources :property_user
end
