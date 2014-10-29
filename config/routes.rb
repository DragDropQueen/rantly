Rails.application.routes.draw do

  namespace :admin do
    resource :dashboard, only: [:show]
    resources :rants, only: [:index, :update, :destroy]
    resources :users, only: [:index, :update]
    post '/rants', to: 'rants#index'
    get '/rants/spam', to: 'rants#spam', as: 'spam'
  end

  resources :confirmations, only: :show
  resource :dashboard, only: :show
  resources :favorites, only: [:index]
  resources :rants, except: [:new, :index, :edit] do
    resources :comments, only: [:create]
  end
  resources :search, only: [:index, :show, :create]
  resource :session, only: [:create, :new, :destroy]
  resources :users, only: :show, as: 'users' do
    resources :follows, only: [:index]
    resources :comments, only: [:create]
  end
  resource :user, only: [:create, :new, :edit, :update]

  post '/follows/:id', to: 'follows#create', as: 'follow'
  delete '/follows/:id', to: 'follows#destroy'

  post '/favorites/:id', to: 'favorites#create', as: 'favorite'
  delete '/favorites/:id', to: 'favorites#destroy'

  root 'root#show', via: 'get'
end
