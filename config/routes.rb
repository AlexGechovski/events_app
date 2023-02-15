Rails.application.routes.draw do
  devise_for :users
  resources :events
  resources :attendances, only: [:create, :destroy]
  resources :comments

  get 'home/about'
  root "home#index"

  match '/users/:id', to: 'users#show', via: 'get', as: :user
end