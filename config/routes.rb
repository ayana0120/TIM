Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'devise/sessions',
    registrations: 'devise/registrations'
  }

  root "users/top"

  resources :users, only:[:show]
  get "/about" => "users#about"

  resources :items
  get "/items/search" => "items#search"

  resources :genre, only:[:index, :create, :update, :destroy]
end