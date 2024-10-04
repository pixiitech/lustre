Rails.application.routes.draw do
  resources :coin_varieties, only: %i[show index] do
    collection do
      get :search
    end
  end

  resources :pcgs_lookup, only: :index

  # Defines the root path route ("/")
  root "pages#index"
end
