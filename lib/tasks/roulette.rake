namespace :roulette do
  desc "Simulate a roulette spin every 3 minutes"
  task spin: :environment do
    loop do
      RouletteService.spin_roulette
      sleep(180)
    end
  end
end
