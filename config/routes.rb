Rails.application.routes.draw do

  # get "home/index"
  # root to: "home#index"

  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  post '/users' => 'users#create'
  get '/users/' => 'users#show'

end
