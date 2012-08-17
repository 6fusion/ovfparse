require 'spec_helper'

describe VirtualSystem do

  describe 'MyLampService' do
    let(:xml) do
      (Nokogiri::XML(open('spec/fixtures/my_lamp_service_virtual_system.xml'))/'VirtualSystem').first
    end
    let(:vm) { VirtualSystem.new(xml) }
    subject { vm }
    its(:name) { should == "MyLampService" }
    its(:info) { should == "Single-VM Virtual appliance with LAMP stack" }
    its(:cpus) { should == 1 }
    its(:memory) { should == 256 }
    its(:operating_system) { should == "Linux 2.6.x" }

    describe 'disks' do
      subject { vm.disks }

      it { should be_an(Array) }
      it { should have(1).elements }

      describe 'first disk' do
        subject { vm.disks.first }
        its(['Caption']) { should == "Harddisk 1" }
        its(['ElementName']) { should == "Hard disk " }
        its(['InstanceID']) { should == "5" }
        its(['ResourceType']) { should == '17' }
        its(['HostResource']) { should == "ovf://disk/lamp" }
      end
    end

    describe 'network cards' do
      subject { vm.network_cards }
      it { should be_an(Array) }
      it { should have(1).elements }

      describe 'first card' do
        subject { vm.network_cards.first }
        its(['AutomaticAllocation']) { should == "true" }
        its(['Caption']) { should == "Ethernet adapter on 'VM Network'" }
        its(['Connection']) { should == "VM Network" }
        its(['ElementName']) { should == "VM network" }
        its(['InstanceID']) { should == "3" }
        its(['ResourceType']) { should == "10" }
      end
    end

    describe 'scsi adapters' do
      subject { vm.scsi_adapters }
      it { should be_an(Array) }
      it { should have(1).elements }

      describe 'first adapter' do
        subject { vm.scsi_adapters.first }
        its(['Caption']) { should == "SCSI Controller 0 - LSI Logic" }
        its(['ElementName']) { should == "LSILOGIC" }
        its(['InstanceID']) { should == "4" }
        its(['ResourceSubType']) { should == "LsiLogic" }
        its(['ResourceType']) { should == "6" }


      end
    end
  end
end