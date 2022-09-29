Rails.application.routes.draw do
  root to: 'home#index'
  resources :modes_of_transport, only:[:index]
end
