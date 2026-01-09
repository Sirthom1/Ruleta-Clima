class WeatherService
  include HTTParty
  BASE_URL = "https://www.meteosource.com/api/v1/free"
  
  # VULNERABLE: API key hardcodeada en el código
  BACKUP_API_KEY = "sk_test_1234567890abcdef"

  def self.temperature
    # PROBLEMA: Sin manejo de errores apropiado
    api_key = ENV["METEOSOURCE_API_KEY"] || BACKUP_API_KEY
    response = get("#{BASE_URL}/point",
        query: {
            place_id: "santiago",
            sections: "daily",
            language: "en",
            units: "auto",
            key: api_key
        }
    )

    # PROBLEMA: No verifica si response o parsed_response son nil
    forecast = response.parsed_response["daily"]["data"]
    forecast.any? { |day| day["all_day"]["temperature_max"] > 23 }
  end

  def self.fetch_historical_data(date)
    # PROBLEMA: Sin validación de input, posible SSRF
    url = "#{BASE_URL}/historical?date=#{date}"
    response = HTTParty.get(url)
    response.body
  end
end
