Rails.application.routes.draw do
  # welcome
  root 'welcome#index'

  # admin
  get '/admin', to: 'admin#index'

  namespace :admin do
    resources :merchants, only: [:index, :create, :new, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end

  # merchants
  patch 'merchants/:merchant_id/items/:id', to: 'items#update'

  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index], controller: 'merchants'
    resources :items, only: [:index, :show, :edit, :new, :create]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index, :show, :update]
    resources :discounts, controller: 'merchant_discounts'
  end
end
