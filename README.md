# One Wire
This is a ruby gem offering binding to w1-gpio kernel module.

GPIO w1 bus master driver by Ville Syrjala <syrjala@sci.fi>

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
#or 
gem install sysfs_one_wire
```

for loading after reboot and depending on your OS you could try following commands

### Debian/Raspian/Ubuntu
```
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
	OneWire.slaves # return the paths of the slaves
	OneWire.find(/2GAE/) # return the paths of corresponding slave.

	OneWire.load(path) # return the devices objects for a given path
	OneWire.devices # return all the devices objects
```

### Extend
```ruby
class Mermory < OneWire::Base

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
```

## Limitation/Alternative
This is a work in progress. It only support thermometer for now, but will be extented (and this is quite easy to do it)

If you need more, Maxim's Integrated offers a whole filesystem with OWFS

[https://github.com/mholling/one_wire]
[https://github.com/pedrocr/ownet]


**Need this? come and give a hand !**
