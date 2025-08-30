class GameRound < ApplicationRecord
  has_many :bets, dependent: :destroy
  validates :result_color, presence: true, inclusion: { in: %w[verde rojo negro] }
  validates :played_at, presence: true
end
