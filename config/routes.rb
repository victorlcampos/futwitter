Futwitter::Application.routes.draw do
  resources :teams, only: [:show]
  resources :matches, only: [:show]
  root to: 'home#index'
end
