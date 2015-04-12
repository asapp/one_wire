require 'one_wire/base'
require 'one_wire/thermometer'

module OneWire
  class << self
  # w1_bq27000 w1_ds2413 w1_ds2431 w1_ds2760 w1_ds2781 w1-gpio w1_therm    
  # w1_ds2408 w1_ds2423 w1_ds2433 w1_ds2780 w1_ds28e04 w1_smem 
  
    # TODO test this for debian/ubuntu
    # def modprobe *args
    #   `modprobe -a #{args.unshift('w1-gpio').compact.join(' ')}`
    # end

    # TODO implement this
    # def install
    #   raise NotImplementedError
    #   # Debian/raspian
    #   '/etc/modules.conf'
    #   '/etc/modprobe.d/modeprobe.conf'
    #   '/etc/modprobe.d/'
    #   'dtoverlay=w1-gpio,gpiopin=4' > '/boot/config.txt'

    #   # Ubuntu
    #   '/etc/modules'
    #   '/etc/modules-load.d/'
    # end

    def slaves &block
      Dir.glob(File.join(File::SEPARATOR, 'sys', 'bus', 'w1', 'devices', '*-*'), &block)
    end

    def find query
      slaves.keep_if { |v| v =~ query }
    end

# Maxim's devices groups
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