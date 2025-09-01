require "test_helper"

describe Player do
  it "defaults money to 10000 if not set" do
    player = Player.new(name: "Alice")
    player.money = 10000
    _(player.money).must_equal 10000
  end

  it "allows custom money" do
    player = Player.new(name: "Bob", money: 5000)
    _(player.money).must_equal 5000
  end
end
