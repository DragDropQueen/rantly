Rails.application.routes.draw do

  resource :dashboard, only: 'show'
  resources :favorites, only: :index
  resources :rants, except: [:new, :index] do
    resources :favorites, only: [:create], shallow: true
  end
  resources :search, only: [:index, :show, :create]
  resource :session, only: [:create, :new, :destroy]
  resources :users, only: :show, as: 'users' do
    resources :follows, only: [:index, :create, :destroy], shallow: true
  end
  resource :user, only: [:create, :new, :edit, :update]

  root 'root#show', via: 'get'
end
