require "test_helper"

describe DailyBonusService do
  before do
    @player = Player.create!(name: "Alice", money: 5000)
  end

  it "adds bonus to player money" do
    DailyBonusService.apply_bonus
    _(@player.reload.money).must_equal 15000
  end

  it "applies bonus to multiple players" do
    player2 = Player.create!(name: "Bob", money: 2000)
    DailyBonusService.apply_bonus
    _(@player.reload.money).must_equal 15000
    _(player2.reload.money).must_equal 12000
  end
end
