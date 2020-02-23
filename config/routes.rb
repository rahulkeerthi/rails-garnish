Rails.application.routes.draw do
  root to: 'cocktails#index'
  resources :cocktails, except: :index
end
