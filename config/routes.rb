Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  get "home/index"

  root to: "home#index"



end
