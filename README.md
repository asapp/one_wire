# One Wire
This is a ruby gem offering binding to w1-gpio kernel module.

GPIO w1 bus master driver by Ville Syrjala <syrjala@sci.fi>

https://www.kernel.org/doc/Documentation/w1/w1.generic

## Installation
`w1-gpio` module should be loaded,
```
modprobe w1-gpio
```

depending on the device you want to control load one of these.
```
modprobe -a w1_bq27000 w1_ds2413 w1_ds2431 w1_ds2760 w1_ds2781 w1_therm w1_ds2408 w1_ds2423 w1_ds2433 w1_ds2780 w1_ds28e04 w1_smem
```
and of course
```ruby
gem 'sysfs_one_wire'
#or in shell
gem install sysfs_one_wire
```

for loading the modules after reboot you need to add them in the boot sequence check these files depending on your OS

### Debian/Raspian/Ubuntu
```
/etc/modules
/etc/modules.conf
/etc/modprobe.d/modeprobe.conf
/etc/modprobe.d/
```

### Raspian
You will also need to activate the device tree :
```
cat 'dtoverlay=w1-gpio' > /boot/config.txt
```

## Usage
```ruby
	OneWire.slaves # return the paths of all the slaves on the line.
	OneWire.find(/2GAE/) # return the paths of slaves with the given pattern as id.

	OneWire.load(path) # return the devices objects for a given path
	OneWire.devices # return all the devices objects
```

Ok, with `OneWire.devices` we can see our sensor is well recognized because they are instantiated with a subclass of OneWire::Base given their type (Thermometer, switch, ...)
Now, can get the corresponding OneWire::Thermometer object, with :

```ruby
soil_sensor = OneWire.devices.first # if it is the first in the list
# or
soil_sensor = OneWire.load('/sys/bus/w1/devices/28-031581efxxxx') # because we already had the path, in a database for example...
```
then you have access  to some methods such as :
```ruby
soil_sensor.value               # current temperature in °C
soil_sensor.last_value          # last checked temperature, return nil if you didn't called value before
soil_sensor.id                  # 1wire device unique id, WARNING: this one is not tested
soil_sensor.name                # device unique name
soil_sensor.w1_slave            # return the w1_slave file, as in 'cat'
soil_sensor.dump                # return an array which can be stored in database for later usage.
```

### Extend
I currently have only a DS18B20 to build and test this gem, but you can also extend it for memory, switch, or others devices supported by the kernel driver.

It is pretty easy to create other object by subclassing OneWire::Base.

```ruby
module OneWire
	class Memory < OneWire::Base

	  PREFIX = %w{06 08 0A 0C}
	  attr_reader :last_value

	  def value
	    @last_value = @value
	    @value = w1_slave[/some regexp to isolate the content/, 1]
	  end

	  def value= arg
	   @last_value = @value
	   File.write(File.join(@path.to_s, 'w1_slave'), arg)
	  end
	end
end
```

## Limitation/Alternative
This is a work in progress. It only support thermometer for now, but will be extented (and this is quite easy to do it)

If you need more, Maxim's Integrated offers a whole filesystem with OWFS

[https://github.com/mholling/one_wire]
[https://github.com/pedrocr/ownet]


**Need this? come and give a hand !**
