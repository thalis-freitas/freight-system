Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :mode_of_transports, only:[:index, :new, :create, :show, :edit, :update]
end
