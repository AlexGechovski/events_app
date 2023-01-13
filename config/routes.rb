Rails.application.routes.draw do
  
  get 'users/index'
  devise_for :users
  resources :events 
  resources :comments


  get 'home/about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  match '/users', to: 'users#index', via: 'get'
  match '/users/:id', to: 'users#show', via: 'get', as: :user
  
end
