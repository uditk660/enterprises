Rails.application.routes.draw do
  devise_for :users
  resources :bills
  root 'bills#index'
end
