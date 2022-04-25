Rails.application.routes.draw do
  devise_for :users
  resources :domains
  root 'application#index'
  get 'demo', to: 'demo#index'
  post 'api/event', to: 'events#create'
  options 'api/event', to: 'events#create'
end
