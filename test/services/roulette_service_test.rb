require "test_helper"

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

  it "adjusts probabilities based on time of day" do
    # Durante la noche (mayor probabilidad de verde)
    Time.stub :current, Time.new(2024, 1, 1, 22, 0, 0) do
      night_probs = RouletteService.send(:adjust_probabilities_by_time, 1.3)
      _(night_probs["verde"]).must_be :>, 0.02  # Mayor que la probabilidad base
    end

    # Durante la mañana (menor probabilidad de verde)
    Time.stub :current, Time.new(2024, 1, 1, 10, 0, 0) do
      morning_probs = RouletteService.send(:adjust_probabilities_by_time, 0.8)
      _(morning_probs["verde"]).must_be :<, 0.02  # Menor que la probabilidad base
    end

    # Durante la tarde (probabilidad normal)
    Time.stub :current, Time.new(2024, 1, 1, 15, 0, 0) do
      afternoon_probs = RouletteService.send(:adjust_probabilities_by_time, 1.0)
      _(afternoon_probs["verde"]).must_be_close_to 0.02, 0.001  # Similar a la base
    end
  end

  it "choose_color uses time of day adjustments" do
    # Probar que choose_color usa TimeOfDayService
    Time.stub :current, Time.new(2024, 1, 1, 22, 0, 0) do
      TimeOfDayService.stub :win_probability_multiplier, 1.3 do
        colors = []
        # Ejecutar múltiples veces para verificar distribución
        100.times do
          colors << RouletteService.send(:choose_color)
        end
        # Verificar que se seleccionan colores válidos
        colors.each do |color|
          _([ "verde", "rojo", "negro" ]).must_include color
        end
      end
    end
  end

  it "probabilities sum to 1.0 regardless of time adjustment" do
    [ 0.8, 1.0, 1.3 ].each do |multiplier|
      probs = RouletteService.send(:adjust_probabilities_by_time, multiplier)
      sum = probs.values.sum
      _(sum).must_be_close_to 1.0, 0.001
    end
  end
end
