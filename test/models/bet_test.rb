require "test_helper"

describe Bet do
  it "stores correct attributes" do
    player = Player.create!(name: "Alice", money: 10000)
    round = GameRound.create!(result_color: "rojo", played_at: Time.current)

    bet = Bet.create!(
      player: player,
      game_round: round,
      amount: 1000,
      bet_color: "rojo",
      won: true,
      payout: 2000
    )

    _(bet.player).must_equal player
    _(bet.game_round).must_equal round
    _(bet.won).must_equal true
    _(bet.payout).must_equal 2000
  end
end
