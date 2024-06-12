Rails.application.routes.draw do
  get 'blogs/index'
  get 'blogs/show'

  resources :blogs
  resources :coin_varieties, only: %i[show index]
  resources :pcgs_lookup, only: :index

  # Defines the root path route ("/")
  root "pages#index"
end
