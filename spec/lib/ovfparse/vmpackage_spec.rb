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
        its(['location']) { should == "ComplexOVF-VMW-V8-disk1.vmdk" }
        its(['size']) { should == "17179869184" }
      end
      describe 'vmdisk1' do
        subject { ovf.disks[1] }
        its(['name']) { should == "vmdisk2" }
        its(['location']) { should == "ComplexOVF-VMW-V8-disk2.vmdk" }
        its(['size']) { should == "21474836480" }
      end
    end

    describe 'networks' do
      it { should have(4).networks }
      describe 'network 1' do
        subject { ovf.networks[0] }
        its(['name']) { should == "VINET01" }
      end
      describe 'network 2' do
        subject { ovf.networks[1] }
        its(['name']) { should == "VINET02" }
      end
      describe 'network 3' do
        subject { ovf.networks[2] }
        its(['name']) { should == "VINET03" }
      end
      describe 'network 4' do
        subject { ovf.networks[3] }
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
        describe 'IDE Controller' do
          it { should have(2).ide_controllers }
          describe 'ide controller 0' do
            subject { ovf.virtual_systems.first.ide_controllers[0] }
            its(['Address']) { should == "1" }
            its(['Description']) { should == "IDE Controller" }
            its(['ElementName']) { should == "IDE 1" }
            its(['InstanceID']) { should == "4" }
            its(['ResourceType']) { should == "5" }
          end
          describe 'ide controller 1' do
            subject { ovf.virtual_systems.first.ide_controllers[1] }
            its(['Address']) { should == "0" }
            its(['Description']) { should == "IDE Controller" }
            its(['ElementName']) { should == "IDE 0" }
            its(['InstanceID']) { should == "5" }
            its(['ResourceType']) { should == "5" }
          end
        end

        describe 'SCSI Controller' do
          it { should have(1).scsi_controllers }
          describe 'scsi controller 0' do
            subject { ovf.virtual_systems.first.scsi_controllers.first }
            its(['Address']) { should == "0" }
            its(['Description']) { should == "SCSI Controller" }
            its(['ElementName']) { should == "SCSI controller 0" }
            its(['InstanceID']) { should == "3" }
            its(['ResourceSubType']) { should == "VirtualSCSI" }
            its(['ResourceType']) { should == "6" }
          end
        end

        describe 'floppy drives' do
          it { should have(1).floppy_drives }
          describe 'floppy drive 1' do
            subject { ovf.virtual_systems.first.floppy_drives.first }
            its(['AddressOnParent']) { should == "0" }
            its(['AutomaticAllocation']) { should == "false" }
            its(['Description']) { should == "Floppy Drive" }
            its(['ElementName']) { should == "Floppy drive 1" }
            its(['InstanceID']) { should == "12" }
            its(['ResourceType']) { should == "14" }
          end
        end

        describe 'CD/DVD drives' do
          it { should have(1).optical_drives }
          describe 'optical drive 1' do
            subject { ovf.virtual_systems.first.optical_drives.first }
            its(['AddressOnParent']) { should == "0" }
            its(['AutomaticAllocation']) { should == "true" }
            its(['ElementName']) { should == "CD/DVD drive 1" }
            its(['HostResource']) { should == "ovf:/file/file2" }
            its(['Parent']) { should == "4" }
            its(['InstanceID']) { should == "7" }
            its(['ResourceType']) { should == "15" }
          end
        end

        describe 'disks' do
          it { should have(2).disks }

        end
        describe 'network cards' do
          it { should have(4).network_cards }
          describe 'network card 1' do
            subject { ovf.virtual_systems.first.network_cards[0] }
            its(['AddressOnParent']) { should == "7" }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "VINET01" }
            its(['Description']) { should == "VmxNet3 ethernet adapter on \"VINET01\"" }
            its(['ElementName']) { should == "Network adapter 1" }
            its(['InstanceID']) { should == "8" }
            its(['ResourceSubType']) { should == "VmxNet3" }
            its(['ResourceType']) { should == "10" }
          end
          describe 'network card 2' do
            subject { ovf.virtual_systems.first.network_cards[1] }
            its(['AddressOnParent']) { should == "8" }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "VINET02" }
            its(['Description']) { should == "E1000 ethernet adapter on \"VINET02\"" }
            its(['ElementName']) { should == "Network adapter 2" }
            its(['InstanceID']) { should == "9" }
            its(['ResourceSubType']) { should == "E1000" }
            its(['ResourceType']) { should == "10" }
          end
          describe 'network card 3' do
            subject { ovf.virtual_systems.first.network_cards[2] }
            its(['AddressOnParent']) { should == "9" }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "VINET03" }
            its(['Description']) { should == "VmxNet3 ethernet adapter on \"VINET03\"" }
            its(['ElementName']) { should == "Network adapter 3" }
            its(['InstanceID']) { should == "10" }
            its(['ResourceSubType']) { should == "VmxNet3" }
            its(['ResourceType']) { should == "10" }
          end
          describe 'network card 4' do
            subject { ovf.virtual_systems.first.network_cards[3] }
            its(['AddressOnParent']) { should == "10" }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "VINET04" }
            its(['Description']) { should == "E1000 ethernet adapter on \"VINET04\"" }
            its(['ElementName']) { should == "Network adapter 4" }
            its(['InstanceID']) { should == "11" }
            its(['ResourceSubType']) { should == "E1000" }
            its(['ResourceType']) { should == "10" }
          end

        end
      end
    end

    describe 'annotations' do
      it { should have(1).annotations }
      describe 'first annotation' do
        subject { ovf.annotations.first }
        it { should == "Created using vSphere 5.0\nHardware Version 8" }
      end
    end

  end

  describe 'ComplexVAPP.ovf' do

  end

end