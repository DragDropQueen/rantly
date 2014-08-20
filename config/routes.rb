Rails.application.routes.draw do

  resource :dashboard, only: 'show'
  resource :session, only: [:create, :new, :destroy]
  resources :users

  root 'root#show'
end
