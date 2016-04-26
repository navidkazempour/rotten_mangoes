Rails.application.routes.draw do
  
  get 'sessions/new'

  get 'sessions/create'

  get 'users/new'

  get 'users/create'

  resources :movies
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]


end
