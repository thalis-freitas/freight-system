Rails.application.routes.draw do
  root to: 'home#index'
  resources :mode_of_transports, only:[:index, :new, :create, :show, :edit, :update]
end
