Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root "users#top"

  resources :users, only:[:show]
  get "/about" => "users#about"

  resources :items
  get "search" => "items#search"

  resources :genres, only:[:index, :create, :update, :destroy]
end