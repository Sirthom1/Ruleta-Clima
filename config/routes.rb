Rails.application.routes.draw do
  resources :players
  resources :game_rounds, only: [:index]
  root "game_rounds#index"
end
