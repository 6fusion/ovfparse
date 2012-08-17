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
    it { subject.valid?.should be_true }
    its(:references) { should == [] }

    its(:virtual_systems) { should have(1).entries }

    describe 'first virtual systems' do
      subject { ovf.virtual_systems.first }
      its(:name) { should == "MyLampService" }
      its(:cpus) { should == 1}
      its(:memory) { should == 512}
      it 'inspect' do
        puts "test" + subject.inspect
        fail
      end
      it { should have(1).disks }
      it { should have(1).network_cards }
    end

  end


end