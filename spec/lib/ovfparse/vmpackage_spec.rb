require 'spec_helper'

describe 'VmPackage' do
  context 'someOVF.ovf' do
    let(:ovf) { VmPackage.create('file://spec/fixtures/someOVF.ovf').fetch }
    subject { ovf }
    it { should be_a_kind_of(FileVmPackage) }
    its(:url) { should eql('spec/fixtures/someOVF.ovf') }
    its(:base_path) { should be_nil }
    its(:name) { should eql('someOVF.ovf') }
    its(:version) { should == "1.0" }
    its(:protocol) { should == "file" }
    #it { should be_valid }
    its(:references) { should have(1).entries }

    its(:virtual_systems) { should have(1).entries }

    describe 'first virtual systems' do
      subject { ovf.virtual_systems.first }
      its(:name) { should == "MyLampService" }
      its(:info) { should == "Single-VM Virtual appliance with LAMP stack"}
      its(:operating_system) { should == "Linux 2.6.x"}
      its(:cpus) { should == 1 }
      its(:memory) { should == 256 }
      it { should have(1).disks }
      it { should have(1).network_cards }
    end

  end

  context 'ComplexOVF-VMW-V8.ovf' do
    let(:ovf) { VmPackage.create('file://spec/fixtures/complexOVF-VMW-V8.ovf').fetch }
    subject { ovf }
    it { should be_a_kind_of(FileVmPackage) }
    its(:url) { should eql('spec/fixtures/complexOVF-VMW-V8.ovf') }
    its(:base_path) { should be_nil }
    its(:name) { should eql('complexOVF-VMW-V8.ovf') }
    its(:version) { should be_nil }
    its(:protocol) { should == "file" }
    #it { should be_valid }
    its(:references) { should have(3).entries }

    its(:virtual_systems) { should have(1).entries }

    describe 'virtual system ComplexOVF-VMW-V8' do
      subject { ovf.virtual_systems.first }
      its(:name) { should == "ComplexOVF-VMW-V8" }
      its(:info) { should == "A virtual machine" }
      its(:operating_system) { should == "Red Hat Enterprise Linux 6 (64-bit)" }
      its(:cpus) { should == 8 }
      its(:memory) { should == 10240 }
    end


  end

end