module OneWire
  class Thermometer < Base
    
    PREFIX = %w{10 22 28 3B}

    attr_reader :last_value

    def value
      @last_value = @value
      @value = w1_slave[/t=(\d*)/, 1].to_f / 1000
    end
  end
end
