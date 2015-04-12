require 'one_wire/base'
require 'one_wire/thermometer'

module OneWire
  class << self
    def slaves &block
      Dir.glob(File.join(File::SEPARATOR, 'sys', 'bus', 'w1', 'devices', '*-*'), &block)
    end

    def find query
      slaves.keep_if { |v| v =~ query }
    end

    # def find_by_type
    # end

    # def find_by_id
    # end

    # def find_by_name
    # end

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

    def load path
      case File.basename(path)[/([\da-f]{2})-[\da-f]{12}/, 1]
        when *Thermometer::PREFIX then return Thermometer.new(path)
      #   when *%w{06 08 0A 0C} then Memory.new(path)
        when %{00} then return nil
        else raise "1 wire device family not implemented for `#{path}` with #{File.basename(path)[/([\da-f]{2})-[\da-f]{12}/, 1]} type"
      end
    end

    def devices
      slaves.collect { |path| load(path) }
    end
  end
end