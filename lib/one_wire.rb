require 'one_wire/base'
require 'one_wire/thermometer'

module OneWire
  class << self
    def slaves &block
      Dir.glob(File.join(File::SEPARATOR, 'sys', 'bus', 'w1', 'devices', '*-*'), &block)
    end

    def find query
      query = Regexp.new query if query.is_a? String
      slaves.keep_if { |v| v =~ query }
    end
    
    def all &block
      devices = slaves.collect { |path| load(path) rescue nil }.compact
      devices.each &block if block_given?
      devices
    end

    def load path
      case File.basename(path)[/([\da-f]{2})-[\da-f]{12}/, 1]
        when *Thermometer::PREFIX then return Thermometer.new(path)
      #   when *%w{06 08 0A 0C} then return Memory.new(path)
        when %{00} then return nil
        else Base.new(path)
      end
    end

    def devices
      slaves.collect { |path| load(path) }
    end
  end
end

# Maxim's Integrated devices types :
# Identification only
# Identification plus control
# Identification plus temperature
# Identification plus time
# Identification plus NV SRAM
# Identification plus (one time programmable) OTP EPROM
# Identification plus EEPROM
# Identification plus SHA-1 secure EEPROM
# Identification plus logging
