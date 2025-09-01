require "test_helper"

describe GameRound do
  it "stores result color" do
    round = GameRound.new(result_color: "rojo", played_at: Time.current)
    _(round.result_color).must_equal "rojo"
  end
end
