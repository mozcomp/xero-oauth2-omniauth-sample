Rails.application.routes.draw do
  root to: 'home#index'
  post 'sessions/connect', to: 'sessions#connect'
  get 'auth/:provider/setup', to: 'sessions#setup'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'contacts', to: 'contacts#index'
  get 'organisation', to: 'organisation#index'
end
