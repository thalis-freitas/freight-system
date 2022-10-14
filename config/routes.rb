Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :mode_of_transports, only:[:index, :new, :create, :show, :edit, :update] do 
    post 'active', on: :member
    post 'inactive', on: :member
    resources :price_by_weights, only:[:new, :create, :edit, :update]
    resources :price_per_distances, only:[:new, :create, :edit, :update]
    resources :deadlines, only:[:new, :create, :edit, :update]
  end
  resources :vehicles, only:[:index, :new, :create, :show, :edit, :update] do 
    post 'in_operation', on: :member
    post 'in_maintenance', on: :member
    get 'search', on: :collection
  end
  resources :service_orders, only:[:new, :create, :show, :edit, :update]
end
