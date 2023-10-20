Rails.application.routes.draw do
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  resources :users, only: %i[create show]
  get "profile", to: "users#profile"
  resources :properties
  get "my_property", to: "property_users#my_properties"
  get "favorite", to: "property_users#listfavorites"
  get "contact", to: "property_users#listcontacts"
  get "contact", to: "property_users#listcontacts"
  get "listBestPrice", to: "properties#listBestPrice"
  get "listhome", to: "property_users#listHome"
  get "listland", to: "property_users#listLand"
  put "my_property", to: "property_users#update_my_property"
end
