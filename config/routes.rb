Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :new, :create] 
  resources :posts, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :favorites, only: [:create, :destroy]
end
