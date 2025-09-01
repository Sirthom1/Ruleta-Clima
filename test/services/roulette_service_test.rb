describe RouletteService do
  before do
    Bet.delete_all
    GameRound.delete_all
    Player.delete_all
    @player = Player.create!(name: "Alice", money: 10000)

    WeatherService.stub :temperature, false do
      ClimateManager.stub :weather_forecast, false do
        @round_normal = RouletteService.spin_roulette
      end
    end
  end

  it "creates a GameRound" do
    _(@round_normal).must_be_instance_of GameRound
  end

  it "creates bets for each player" do
    bets = @round_normal.bets
    _(bets.count).must_equal 1
    _(bets.first.player).must_equal @player
  end

  it "calculates bet normally between 8% and 15%" do
    bet_amount = @round_normal.bets.first.amount
    min = (@player.money * 0.08).to_i
    max = (@player.money * 0.15).to_i
    _(bet_amount).must_be :>=, min
    _(bet_amount).must_be :<=, max
  end

  it "calculates all-in for money <= 1000" do
    @player.update!(money: 800)
    WeatherService.stub :temperature, false do
      ClimateManager.stub :weather_forecast, false do
        round = RouletteService.spin_roulette
        bet = round.bets.find_by(player: @player)
        _(bet.amount).must_equal 800
      end
    end
  end

  it "adjusts bet if hot day (temperature > 23)" do
    WeatherService.stub :temperature, true do
      ClimateManager.stub :weather_forecast, true do
        round = RouletteService.spin_roulette
        bet = round.bets.find_by(player: @player)
        min = (@player.money * 0.03).to_i
        max = (@player.money * 0.07).to_i
        _(bet.amount).must_be :>=, min
        _(bet.amount).must_be :<=, max
      end
    end
  end
end
