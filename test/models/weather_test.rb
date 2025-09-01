require "test_helper"

describe Weather do
  it "can be created with date and hot_day" do
    weather = Weather.create!(date: Date.today, hot_day: true)
    _(weather.date).must_equal Date.today
    _(weather.hot_day).must_equal true
  end

  it "requires hot_day to be boolean" do
    weather = Weather.new(date: Date.today, hot_day: nil)
    _(weather.valid?).must_equal false
    _(weather.errors[:hot_day]).must_include "is not included in the list"
  end
end
