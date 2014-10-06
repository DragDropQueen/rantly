Rails.application.routes.draw do

  resources :rants, except: [:new, :index]

  resource :dashboard, only: 'show'
  resource :session, only: [:create, :new, :destroy]
  resource :user, only: [:create, :new, :edit, :update]
  resources :users, only: :show do
    resources :follows, only: [:index, :create, :destroy], shallow: true
  end

  root 'root#show', via: 'get'
end
