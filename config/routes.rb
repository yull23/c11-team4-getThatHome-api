Rails.application.routes.draw do
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  resources :users, only: %i[create show]
  get "profile", to: "users#profile"
  resources :properties
  resources :property_users
  get "favorite", to: "property_users#listfavorites"
  get "contact", to: "property_users#listcontacts"
  get "listBestPrice", to: "properties#listBestPrice"
end
