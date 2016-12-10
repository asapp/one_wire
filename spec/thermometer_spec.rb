require 'spec_helper'

describe OneWire::Thermometer do
  before do
    allow(File).to receive(:join).and_call_original
    allow(File).to receive(:join).with(File::SEPARATOR, 'sys', 'bus', 'w1', 'devices', '*-*').and_return(File.expand_path "#{__dir__}/fixtures/sys_bus_w1_devices/*-*")
  end

  context "with positive value" do
    subject {OneWire::Thermometer.new(OneWire.find(/-000000000003/).first)}

    it { is_expected.to be_kind_of OneWire::Thermometer }
    it { expect(subject.name).to eq "28-000000000003" }
    xit { expect(subject.id).to eq "" } # don't know how to read `id` file
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

  context "with negative value" do
    subject {OneWire::Thermometer.new(OneWire.find(/28-000000000004/).first)}
    it { is_expected.to be_kind_of OneWire::Thermometer }
    it { expect(subject.name).to eq "28-000000000004" }
    xit { expect(subject.id).to eq "" } # don't know how to read `id` file
    it { expect(subject.w1_slave).to eq "9f 01 4b 46 7f ff 01 10 40 : crc=40 YES\n9f 01 4b 46 7f ff 01 10 40 t=-25937" }
    it { expect(subject.value).to eq -25.937 }
    it "should update the last value" do
      expect(subject.last_value).to be_nil
      subject.value
      expect(subject.last_value).to be_nil
      subject.value
      expect(subject.last_value).to eq -25.937
    end
  end
end
