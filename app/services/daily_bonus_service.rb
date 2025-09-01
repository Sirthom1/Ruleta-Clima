class DailyBonusService
    def self.apply_bonus
        Player.find_each do |player|
            player.increment!(:money, 10000)
        end
    end
end