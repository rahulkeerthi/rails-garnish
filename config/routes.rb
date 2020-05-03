Rails.application.routes.draw do
  devise_for :users
  root to: 'cocktails#index'
  resources :cocktails, except: :index do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: :destroy
end
