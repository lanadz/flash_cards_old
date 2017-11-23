Rails.application.routes.draw do
  resources :flash_cards, only: [:show]
  resources :categories, only: [:show, :index]
  resources :learning_sessions, only: [:create]
  resources :registrations, only: [:create]

  get '/status.json', to: 'status#show'

  namespace :teacher do
    resources :flash_cards
    resources :categories, only: [:show, :create, :index]
  end
end
