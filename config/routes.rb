Futwitter::Application.routes.draw do
  resources :teams, only: [:show]
  resources :matches, only: [:show]
  root to: 'home#index'

  mount Resque::Server.new, :at => "/workers"
end
