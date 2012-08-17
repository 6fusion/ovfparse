require 'spec_helper'

describe 'VmPackage' do
  context 'someOVF.ovf' do
    let(:ovf) { VmPackage.create('file://fixtures/someOVF.ovf').fetch }
    subject { ovf }
    it { should be_a_kind_of(FileVmPackage) }
    its(:url) { should eql('fixtures/someOVF.ovf') }
    its(:base_path) { should be_nil }
    its(:name) { should eql('someOVF.ovf') }
    its(:version) { should == "1.0" }
    its(:protocol) { should == "file" }
    its(:size) { should == 0 }
    it { subject.valid?.should be_true }
    its(:references) { should == []}

    its(:virtual_machines) { should have(1).entries }

    describe 'first virtual machine' do
      subject { ovf.virtual_machines.first }
      its(:system) { should == {}}
      its(:disks) {should == []}
      its(:networks) {should == []}
    end

  end


end