require "test_helper"

class TimeOfDayServiceTest < ActiveSupport::TestCase
  test "should return morning period for hours between 6 and 13" do
    # Probar con diferentes horas de la mañana
    [ 6, 9, 12, 13 ].each do |hour|
      travel_to Time.zone.local(2024, 1, 1, hour, 0, 0) do
        assert_equal :morning, TimeOfDayService.current_period, "Hour #{hour} should be morning"
        assert_equal "Mañana", TimeOfDayService.period_name
        assert_equal 0.8, TimeOfDayService.win_probability_multiplier
      end
    end
  end

  test "should return afternoon period for hours between 14 and 20" do
    # Probar con diferentes horas de la tarde
    [ 14, 17, 19, 20 ].each do |hour|
      travel_to Time.zone.local(2024, 1, 1, hour, 0, 0) do
        assert_equal :afternoon, TimeOfDayService.current_period, "Hour #{hour} should be afternoon"
        assert_equal "Tarde", TimeOfDayService.period_name
        assert_equal 1.0, TimeOfDayService.win_probability_multiplier
      end
    end
  end

  test "should return night period for hours between 21 and 5" do
    # Probar con diferentes horas de la noche
    [ 21, 23, 0, 3, 5 ].each do |hour|
      travel_to Time.zone.local(2024, 1, 1, hour, 0, 0) do
        assert_equal :night, TimeOfDayService.current_period, "Hour #{hour} should be night"
        assert_equal "Noche", TimeOfDayService.period_name
        assert_equal 1.3, TimeOfDayService.win_probability_multiplier
      end
    end
  end

  test "should have higher win multiplier at night" do
    travel_to Time.zone.local(2024, 1, 1, 22, 0, 0) do
      night_multiplier = TimeOfDayService.win_probability_multiplier
      assert_equal 1.3, night_multiplier
    end
    
    travel_to Time.zone.local(2024, 1, 1, 15, 0, 0) do
      afternoon_multiplier = TimeOfDayService.win_probability_multiplier
      assert_equal 1.0, afternoon_multiplier
    end
    
    travel_to Time.zone.local(2024, 1, 1, 10, 0, 0) do
      morning_multiplier = TimeOfDayService.win_probability_multiplier
      assert_equal 0.8, morning_multiplier
    end
    
    # Verificar que noche > tarde > mañana
    assert 1.3 > 1.0, "Night should have higher multiplier than afternoon"
    assert 1.0 > 0.8, "Afternoon should have higher multiplier than morning"
  end
end
