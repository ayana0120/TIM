Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks",
  }

  root "users#top"

  resources :users, only: [:show]
  get "/about" => "users#about"

  resources :items
  get "search" => "items#search"
  patch "quantity_decreases/:id" => "items#quantity_decreases", as: "quantity_decreases"
  patch "quantity_increases/:id" => "items#quantity_increases", as: "quantity_increases"

  resources :genres, only: [:index, :create, :update, :destroy]

  devise_scope :user do
    post "users/guest_sign_in" => "users/sessions#new_guest"
  end
end
