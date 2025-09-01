require "test_helper"

class ClimateManagerTest < ActiveSupport::TestCase
  test "returns hot_day status as true or false" do
    weather = ClimateManager.weather_forecast
    _(weather).must_be :in?, [ true, false ]
  end
end
