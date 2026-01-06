Rails.application.routes.draw do
  devise_for :users
  resources :bills
  resources :companies do
    resources :employees do
      resources :employee_documents, only: [:index, :create, :destroy]
      resources :employee_salary_structures
      resources :employee_monthly_salaries do
        post :confirm_payment, on: :member
        get :print, on: :member
        get :salary_ledger, on: :member
      end
    end
  end
  
  resources :invoices do
    member do
      get :ledger
    end
  end
  # resources :payments, only: [:index, :show, :new, :create]
  resources :customers do
    resources :payments, only: [:index, :show, :new, :create] do
      member do
        get :print
      end
    end

    member do
      get :ledger
    end
  end

  resources :ledger_entries do
    collection do
      get :export
    end
  end

  root 'bills#index'
end
