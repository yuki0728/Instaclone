Rails.application.routes.draw do
  root   'pages#home'

  get    '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resource :users
  resource :post, only: [:new, :create, :destroy]
end
