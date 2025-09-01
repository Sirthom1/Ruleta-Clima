namespace :daily do
    desc "Apply daily bonus to all players"
    task bonus: :environment do
        DailyBonusService.apply_bonus
    end
end
