module OneWire
  class Thermometer < Base
    
    PREFIX = %w{10 22 28 3B}
    attr_accessor :force

    def frame force = false
      w1_slave(force || @force)[/([a-f0-9 ]{9}) t=/, 1]
    end

    def value force = false
      @last_value = @value
      @value = w1_slave(force || @force)[/t=(\d*)/, 1].to_i
    end

    def last_value
      @last_value
    end

    alias_method :temp, :value
  end
end
