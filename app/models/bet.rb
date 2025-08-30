class Bet < ApplicationRecord
  belongs_to :player
  belongs_to :game_round

  validates :amount, numericality: { greater_than: 0 }
  validates :bet_color, presence: true, inclusion: { in: %w[verde rojo negro] }
end
