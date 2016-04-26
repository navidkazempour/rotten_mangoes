Rails.application.routes.draw do
  
  get 'users/new'

  get 'users/create'

  resources :movies
  resources :users, only: [:new, :create]

end
