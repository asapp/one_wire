require 'spec_helper'

describe OneWire do
  before do 
    allow(File).to receive(:join).and_call_original
    allow(File).to receive(:join).with(File::SEPARATOR, 'sys', 'bus', 'w1', 'devices', '*-*').and_return(File.expand_path "#{__dir__}/../fixtures/sys_bus_w1_devices/*-*")
  end

  it { expect(subject.slaves).to all( match /fixtures\/sys_bus_w1_devices\/.{2}-.{12}/ ) }

  xit { expect(subject.find "00-").to all( match "00-" ) }
  xit { expect(subject.find "00-").to all( match /00-/ ) }
  it { expect(subject.find /00-/).to all( match "00-" ) }
  it { expect(subject.find /00-/).to all( match /00-/ ) }
  it { expect(subject.find(/00-/).first).to match /fixtures\/sys_bus_w1_devices\/0{2}-0{12}/ }

  it { expect(subject.load(subject.find(/00-/).first)).to be_nil}
  it { expect(subject.load(subject.find(/28-/).first)).to be_kind_of OneWire::Thermometer}
  it { expect { subject.load(subject.find(/08-/).first) }.to raise_error}

  describe OneWire::Base do
    it { is_expected.to be_kind_of OneWire::Base }
    it { expect{ subject.name }.to raise_error Errno::ENOENT }
    
    let(:empty_device) {OneWire::Base.new(OneWire.find(/00-/).first)}
    it { expect(empty_device.name).to eq "00-000000000000" }
    xit { expect(empty_device.id).to eq "" }
    it { expect(empty_device.w1_slave).to eq "empty device" }

    it { expect { empty_device.value }.to raise_error(NotImplementedError) }
    it { expect { empty_device.last_value }.to raise_error(NotImplementedError) }
  end

  describe OneWire::Thermometer do    
    subject {OneWire::Thermometer.new(OneWire.find(/-000000000003/).first)}

    it { is_expected.to be_kind_of OneWire::Thermometer }
    it { expect(subject.name).to eq "28-000000000003" }
    xit { expect(subject.id).to eq "" }
    it { expect(subject.w1_slave).to eq "9f 01 4b 46 7f ff 01 10 40 : crc=40 YES\n9f 01 4b 46 7f ff 01 10 40 t=25937" }
    it { expect(subject.value).to eq 25.937 }

    it "should update the last value" do 
      expect(subject.last_value).to be_nil
      subject.value
      expect(subject.last_value).to be_nil
      subject.value
      expect(subject.last_value).to eq 25.937
    end
  end
end