class GameRoundsController < ApplicationController
  def index
    @game_rounds = GameRound.includes(bets: :player).order(played_at: :desc)
  end

  def spin
    RouletteService.spin_roulette
    render plain: "Spin executed at #{Time.now}"
  rescue => e
    render plain: "Error: #{e.message}", status: 500
  end

  def bonus
    DailyBonusService.apply_bonus
    render plain: "Daily bonus applied at #{Time.now}"
  rescue => e
    render plain: "Error: #{e.message}", status: 500
  end
end
