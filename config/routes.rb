Rails.application.routes.draw do
  devise_for :users
  resources :bills
  resources :companies
  resources :invoices
  # resources :payments, only: [:index, :show, :new, :create]
  resources :customers do
    resources :payments, only: [:index, :show, :new, :create]
    member do
      get :ledger
    end
  end
  root 'bills#index'
end
