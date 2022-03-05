Rails.application.routes.draw do
  resources :domains
  root 'domains#index'
  post 'api/event', to: 'events#create'
end
