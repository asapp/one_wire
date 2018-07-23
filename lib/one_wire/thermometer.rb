module OneWire
  class Thermometer < Base

    PREFIX = %w{10 22 28 3B}

    attr_reader :last_value

    def value
      @last_value = @value
      status_line, temperature_line = w1_slave.split("\n")
      raise SensorNotReady unless status_line.end_with?('YES')
      @value = temperature_line[/t=(-?\d*)/, 1].to_f / 1000
    end
  end
end
