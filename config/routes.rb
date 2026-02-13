Rails.application.routes.draw do
  resources :players do
    collection do
      get :search
    end
    member do
      patch :admin_update
    end
  end
  resources :game_rounds, only: [ :index ] do
    collection do
      get :stats
    end
  end
  root "game_rounds#index"
end
