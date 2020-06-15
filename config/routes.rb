Rails.application.routes.draw do
  root   'pages#home'

  get    '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users, only: [:new, :create, :destroy, :show] do
    member do
      get :following, :followers
    end
  end
  resources :post, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
