Rails.application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'cocktails#index'

  resources :cocktails, except: :index do
    resources :doses, only: [:new, :create]
  end

  resources :cocktails, only: :index
  resources :doses, only: :destroy

end
