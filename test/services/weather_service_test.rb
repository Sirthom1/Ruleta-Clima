require "test_helper"

describe WeatherService do
  it "temperature returns true or false" do
    result = WeatherService.temperature
    _(result).must_be :in?, [ true, false ]
  end
end
