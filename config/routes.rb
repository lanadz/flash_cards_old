Rails.application.routes.draw do
  resources :flash_cards, only: [:create, :destroy]
  resources :categories, only: [:show, :index, :create]
  resources :learning_sessions, only: [:create, :update]
  resources :registrations, only: [:create]
  resources :sessions, only: [:create] do
    collection do
      delete :signout
    end
  end

  get '/status.json', to: 'status#show'
end
