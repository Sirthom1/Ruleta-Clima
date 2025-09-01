class ClimateManager
    def self.weather_forecast
        today = Date.today
        record = Weather.find_by(date: today)

        if record
            record.hot_day
        else
            begin
                hot = WeatherService.temperature
            rescue => e
                Rails.logger.error("Failed to update weather: #{e.message}")
                hot = false
            end
            Weather.create(date: today, hot_day: hot)
            hot
        end
    end
end
