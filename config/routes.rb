Rails.application.routes.draw do
  resources :flash_cards, only: [:show]
  resources :categories, only: [:show, :index]

  namespace :teacher do
    resources :flash_cards
    resources :categories, only: [:show, :create, :index]
  end
end
