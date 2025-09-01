class GameRoundsController < ApplicationController
  def index
    @game_rounds = GameRound.includes(bets: :player).order(played_at: :desc)
  end
end
