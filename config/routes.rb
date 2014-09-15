Rails.application.routes.draw do

  resources :rants, except: [:new, :index]

  resource :dashboard, only: 'show'
  resource :session, only: [:create, :new, :destroy]
  resource :user

  root 'root#show'
end
