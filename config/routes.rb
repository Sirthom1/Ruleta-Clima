Rails.application.routes.draw do
  resources :players
  resources :game_rounds, only: [ :index ]
  root "game_rounds#index"
  post '/spin', to: 'game_rounds#spin'
  post '/bonus', to: 'game_rounds#bonus'
end
