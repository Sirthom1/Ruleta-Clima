class WeatherService
  include HTTParty
  BASE_URL = "https://www.meteosource.com/api/v1/free"

  def self.temperature
    api_key = ENV["METEOSOURCE_API_KEY"]
    response = get("#{BASE_URL}/point",
        query: {
            place_id: "santiago",
            sections: "daily",
            language: "en",
            units: "auto",
            key: api_key
        }
    )

    if response.code != 200
        raise "Weather API Error: #{response.code}"
    end

    forecast = response.parsed_response["daily"]["data"]
    forecast.any? { |day| day["all_day"]["temperature_max"] > 23 }
  end
end
