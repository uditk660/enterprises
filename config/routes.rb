Rails.application.routes.draw do
  devise_for :users
  resources :bills
  resources :customers
  resources :companies
  resources :invoices
  root 'bills#index'
end
