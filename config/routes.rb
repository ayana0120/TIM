Rails.application.routes.draw do
  get 'genres/index'
  get 'items/index'
  get 'items/new'
  get 'items/show'
  get 'items/edit'
  get 'items/search'
  get 'users/show'
  get 'users/top'
  get 'users/about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
