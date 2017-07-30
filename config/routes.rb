Rails.application.routes.draw do
  resources :flash_cards, only: [:show]

  namespace :teacher do
    resources :flash_cards
    resources :categories, only: [:show, :create, :index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
