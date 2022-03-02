Rails.application.routes.draw do
  resources :domains
  post "events/event", to: 'events#event'
end
