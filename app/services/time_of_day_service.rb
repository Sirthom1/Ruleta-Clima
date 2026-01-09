class TimeOfDayService
  # Define los rangos horarios:
  # Mañana: 6:00 - 13:59
  # Tarde: 14:00 - 20:59
  # Noche: 21:00 - 5:59
  
  MORNING_RANGE = (6..13).freeze
  AFTERNOON_RANGE = (14..20).freeze
  # Noche es de 21 a 5 (cruza medianoche)

  def self.current_period
    hour = Time.current.hour
    
    if MORNING_RANGE.cover?(hour)
      :morning
    elsif AFTERNOON_RANGE.cover?(hour)
      :afternoon
    else
      :night
    end
  end

  # Multiplicadores de probabilidad de ganar
  # Noche: mayor probabilidad (1.3x)
  # Tarde: probabilidad normal (1.0x)
  # Mañana: menor probabilidad (0.8x)
  def self.win_probability_multiplier
    case current_period
    when :morning
      0.8
    when :afternoon
      1.0
    when :night
      1.3
    end
  end

  def self.period_name
    case current_period
    when :morning
      "Mañana"
    when :afternoon
      "Tarde"
    when :night
      "Noche"
    end
  end
end
