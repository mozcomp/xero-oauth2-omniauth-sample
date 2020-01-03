Rails.application.routes.draw do
  root to: 'home#index'
  get 'auth/:provider/setup', to: 'sessions#setup'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'contacts', to: 'contacts#index'
  get 'organisation', to: 'organisation#index'
end
