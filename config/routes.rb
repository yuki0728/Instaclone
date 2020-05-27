Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root   'pages#home'

  get    '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resource :users do
    resource :relationships, only: [:create, :destroy]
    member do
      get :following, :followers
    end
  end
  resource :post, only: [:new, :create, :destroy]
end
