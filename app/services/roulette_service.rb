class RouletteService
    COLORS = { "verde" => 0.02, "rojo" => 0.49, "negro" => 0.49 }

    def self.spin_roulette
        result_color = spin
        round = GameRound.create(result_color: result_color, played_at: Time.current)

        Player.all.each do |player|
            next if player.money <= 0

            bet_amount = calculate_bet(player.money)
            bet_color = choose_color
            won, payout = result_spin(bet_amount, bet_color, result_color)

            Bet.create(
                player: player,
                game_round: round,
                amount: bet_amount,
                bet_color: bet_color,
                won: won,
                payout: payout
            )

            player.update(money: player.money - bet_amount + payout)
        end

        round
    end

    private

    def self.spin
        rand_value = rand
        cumulative_probability = 0.0

        COLORS.each do |color, probability|
            cumulative_probability += probability
            return color if rand_value < cumulative_probability
        end
    end

    def self.calculate_bet(money)
        conservative_bet = ClimateManager.weather_forecast
        if money <= 1000
            money
        else
            range = conservative_bet ? 0.03..0.07 : 0.08..0.15
            (money * rand(range)).to_i
        end
    end

    def self.choose_color
        rand_value = rand
        cumulative_probability = 0.0

        COLORS.each do |color, probability|
            cumulative_probability += probability
            return color if rand_value < cumulative_probability
        end
    end

    def self.result_spin(bet_amount, bet_color, result_color)
        if bet_color == result_color
            payout = result_color == "verde" ? bet_amount * 15 : bet_amount * 2
            [ true, payout ]
        else
            [ false, 0 ]
        end
    end
end
