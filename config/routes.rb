Rails.application.routes.draw do
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  resources :users, only: %i[create show]

  resources :properties
  resources :property_users
  get 'favorite', :to => 'property_users#favorite'
end
