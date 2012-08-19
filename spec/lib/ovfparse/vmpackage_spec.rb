require 'spec_helper'

describe 'VmPackage' do
  context 'someOVF.ovf' do
    let(:ovf) { VmPackage.create('file://spec/fixtures/someOVF.ovf').fetch }
    subject { ovf }
    it { should be_a_kind_of(FileVmPackage) }
    its(:url) { should eql('spec/fixtures/someOVF.ovf') }
    its(:uri) { should eql('file://spec/fixtures/someOVF.ovf') }
    its(:base_path) { should be_nil }
    its(:name) { should eql('someOVF.ovf') }
    its(:version) { should == "1.0" }
    its(:protocol) { should == "file" }
    #it { should be_valid }

    describe 'files' do
      it { should have(1).files }
    end

    describe 'virtual_systems' do
      it { should have(1).virtual_systems }
      describe 'first virtual systems' do
        subject { ovf.virtual_systems.first }
        its(:name) { should == "MyLampService" }
        its(:info) { should == "Single-VM Virtual appliance with LAMP stack" }
        its(:operating_system) { should == "Linux 2.6.x" }
        its(:cpus) { should == 1 }
        its(:memory) { should == 256 }
        it { should have(1).disks }
        it { should have(1).network_cards }
      end
    end

  end

  context 'ComplexOVF-VMW-V8.ovf' do
    let(:ovf) { VmPackage.create('file://spec/fixtures/complexOVF-VMW-V8.ovf').fetch }
    subject { ovf }
    it { should be_a_kind_of(FileVmPackage) }
    its(:url) { should eql('spec/fixtures/complexOVF-VMW-V8.ovf') }
    its(:uri) { should eql('file://spec/fixtures/complexOVF-VMW-V8.ovf') }
    its(:base_path) { should be_nil }
    its(:name) { should eql('complexOVF-VMW-V8.ovf') }
    its(:version) { should be_nil }
    its(:protocol) { should == "file" }
    #it { should be_valid }

    describe 'files' do
      it { should have(3).files }
      describe 'file1' do
        subject { ovf.files[0] }
        its(['id']) { should == "file1" }
        its(['href']) { should == "ComplexOVF-VMW-V8-disk1.vmdk" }
        its(['size']) { should == "69632" }
      end
      describe 'file2' do
        subject { ovf.files[1] }
        its(['id']) { should == "file2" }
        its(['href']) { should == "ComplexOVF-VMW-V8-file1.iso" }
        its(['size']) { should == "203423744" }
      end
      describe 'file3' do
        subject { ovf.files[2] }
        its(['id']) { should == "file3" }
        its(['href']) { should == "ComplexOVF-VMW-V8-disk2.vmdk" }
        its(['size']) { should == "70144" }
      end
    end

    describe 'disks' do
      it { should have(2).disks }
      describe 'vmdisk1' do
        subject { ovf.disks.first }
        its(['name']) { should == "vmdisk1" }
        its(['location']) { should == "" }
        its(['size']) { should == "17179869184" }
      end
      describe 'vmdisk1' do
        subject { ovf.disks[1] }
        its(['name']) { should == "vmdisk2" }
        its(['location']) { should == "" }
        its(['size']) { should == "21474836480" }
      end
    end

    describe 'networks' do
      it { should have(4).networks }
      describe 'network 1' do
        subject { ovf.networks[0]}
        its(['name']) { should == "VINET01" }
      end
      describe 'network 2' do
        subject { ovf.networks[1]}
        its(['name']) { should == "VINET02" }
      end
      describe 'network 3' do
        subject { ovf.networks[2]}
        its(['name']) { should == "VINET03" }
      end
      describe 'network 4' do
        subject { ovf.networks[3]}
        its(['name']) { should == "VINET04" }
      end
    end

    describe 'virtual_systems' do
      it { should have(1).virtual_systems }
      describe 'virtual system ComplexOVF-VMW-V8' do
        subject { ovf.virtual_systems.first }
        its(:name) { should == "ComplexOVF-VMW-V8" }
        its(:info) { should == "A virtual machine" }
        its(:operating_system) { should == "Red Hat Enterprise Linux 6 (64-bit)" }
        its(:cpus) { should == 8 }
        its(:memory) { should == 10240 }
        it { should have(2).disks }
        it { should have(4).network_cards }
      end
    end

    describe 'annotations' do
      it { should have(1).annotations }

    end

  end

end