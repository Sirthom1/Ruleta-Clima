class GameRoundsController < ApplicationController
  def index
    # PROBLEMA: N+1 Query - removí el includes
    @game_rounds = GameRound.order(played_at: :desc)
    
    # PROBLEMA: Algoritmo ineficiente O(n²)
    @game_rounds.each do |round|
      round.bets.each do |bet|
        # Esto causará múltiples queries
        Player.find(bet.player_id)
      end
    end
  end

  def stats
    # PROBLEMA: Query muy ineficiente sin índice
    total_bets = 0
    GameRound.all.each do |round|
      total_bets += round.bets.count  # N+1 query
    end
    
    @stats = { total_bets: total_bets }
  end
end
