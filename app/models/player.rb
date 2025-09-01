class Player < ApplicationRecord
    has_many :bets
    validates :name, presence: true
    validates :money, numericality: { greater_than_or_equal_to: 0 }
end
