Rails.application.routes.draw do
  get 'blogs/index'
  get 'blogs/show'
  resources :blogs

  # Defines the root path route ("/")
  root "blogs#index"
end
