require 'spec_helper'

describe OneWire do
  before { allow(File).to receive(:join).with(File::SEPARATOR, 'sys', 'bus', 'w1', 'devices', '*-*').and_return("#{File.dirname(__FILE__)}/../fixtures/sys_bus_w1_devices/*-*")  }

  it { expect(subject.slaves).to all( match /fixtures\/sys_bus_w1_devices\/.{2}-.{12}/ ) }
  it { expect(subject.load(subject.slaves.first)).to be_kind_of OneWire::Thermometer}



  describe OneWire::Base do
    subject {OneWire::Base.new()}

    it { is_expected.to be_kind_of OneWire::Base }
    it { expect(subject.name).to eq "" }
    it { expect(subject.id).to eq "" }
    it { expect(subject.w1_slave).to eq "" }

    it { expect { subject.value }.to raise_error(NotImplementedError) }
    it { expect { subject.last_value }.to raise_error(NotImplementedError) }
    it { expect { subject.watch(0) {throw :in_watch_block} }.to throw_symbol(:in_watch_block) }
  end
  describe OneWire::Thermometer do    
    subject {OneWire::Thermometer.new()}
  end
end