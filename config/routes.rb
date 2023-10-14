Rails.application.routes.draw do
  get "home/index"
  #devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users
  root to: "home#index"

  resources :property_types, only: %i[index]
  #post "/properties", to:"properties#create"
  #get "/properties/:id", to:"properties#show"
  #put "/properties/:id", to:"properties#update"
  resources :properties, only: %i[index show create update destroy]
  
end
