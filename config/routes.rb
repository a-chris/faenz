Rails.application.routes.draw do
  devise_for :users
  resources :domains
  root 'domains#index'
  post 'api/event', to: 'events#create'
  options 'api/event', to: 'events#create'
end
