Rails.application.routes.draw do

  # MISC
  ############################################
  root 'pages#home'
  get 'about', to: 'pages#about'

  # ARTICLES
  ############################################
  resources :articles

  # USERS
  ############################################
  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'
  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#show', as: 'user'
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user'

  # SESSIONS
  ############################################
  get 'login', to: 'sessions#login'
  post 'login', to: 'sessions#new'
  delete 'login', to: 'sessions#logout'
end
