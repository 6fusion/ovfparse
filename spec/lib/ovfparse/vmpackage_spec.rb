require 'spec_helper'

describe 'VmPackage' do
  describe 'someOVF.ovf' do
    let(:ovf) { VmPackage.create("file://#{FIXTURE_PATH}/someOVF.ovf").fetch }
    subject { ovf }
    it { should be_a_kind_of(FileVmPackage) }
    its(:url) { should eql("#{FIXTURE_PATH}/someOVF.ovf") }
    its(:uri) { should eql("file://#{FIXTURE_PATH}/someOVF.ovf") }
    its(:base_path) { should be_nil }
    its(:name) { should eql('someOVF.ovf') }
    its(:version) { should == "1.0" }
    its(:protocol) { should == "file" }
    #it { should be_valid }

    describe 'files' do
      it { should have(1).files }
      describe 'file 1' do
        subject { ovf.files[0] }
        its(['id']) { should == "lamp" }
        its(['href']) { should == "lamp.vmdk" }
        its(['size']) { should == "180114671" }
      end
    end

    describe 'disks' do
      it { should have(1).disks }
      describe 'disk 1' do
        subject { ovf.disks[0] }
        its(['name']) { should == "lamp" }
        its(['size']) { should == "4294967296" }
        its(['location']) { should == "lamp.vmdk" }
        its(['format']) { should == "vmdk" }
      end
    end

    describe 'virtual_systems' do
      it { should have(1).virtual_systems }
      describe 'first virtual systems' do
        let(:vm) { ovf.virtual_systems.first }
        subject { vm }
        its(:name) { should == "MyLampService" }
        its(:info) { should == "Single-VM Virtual appliance with LAMP stack" }
        its(:description) { should == ""}
        its(:operating_system) { should == "Linux 2.6.x" }
        its(:cpus) { should == 1 }
        its(:memory) { should == 256 }
        describe 'disks' do
          it { should have(1).disks }
          describe 'disk 1' do
            subject { vm.disks[0] }
            its(['ElementName']) { should == "Hard disk " }
            its(['HostResource']) { should == "ovf://disk/lamp" }
            its(['InstanceID']) { should == "5" }
            its(['Parent']) { should == "4" }
            its(['ResourceType']) { should == "17" }
          end
        end
        describe 'network cards' do
          it { should have(1).network_cards }
          describe 'network card 1' do
            subject { vm.network_cards[0] }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "VM Network" }
            its(['ElementName']) { should == "VM network" }
            its(['InstanceID']) { should == "3" }
            its(['ResourceType']) { should == "10" }
          end
        end
      end
    end

  end

  describe 'ComplexOVF-VMW-V8.ovf' do
    let(:ovf) { VmPackage.create("file://#{FIXTURE_PATH}/ComplexOVF-VMW-V8.ovf").fetch }
    subject { ovf }
    it { should be_a_kind_of(FileVmPackage) }
    its(:url) { should eql("#{FIXTURE_PATH}/ComplexOVF-VMW-V8.ovf") }
    its(:uri) { should eql("file://#{FIXTURE_PATH}/ComplexOVF-VMW-V8.ovf") }
    its(:base_path) { should be_nil }
    its(:name) { should eql('ComplexOVF-VMW-V8.ovf') }
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
        its(['format']) { should == "vmdk" }
      end
      describe 'vmdisk1' do
        subject { ovf.disks[1] }
        its(['name']) { should == "vmdisk2" }
        its(['location']) { should == "ComplexOVF-VMW-V8-disk2.vmdk" }
        its(['size']) { should == "21474836480" }
        its(['format']) { should == "vmdk" }
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
        let(:vm) { ovf.virtual_systems.first }
        subject { vm }
        its(:name) { should == "ComplexOVF-VMW-V8" }
        its(:info) { should == "A virtual machine" }
        its(:description) { should == ""}
        its(:operating_system) { should == "Red Hat Enterprise Linux 6 (64-bit)" }
        its(:cpus) { should == 8 }
        its(:memory) { should == 10240 }
        describe 'IDE Controller' do
          it { should have(2).ide_controllers }
          describe 'ide controller 0' do
            subject { vm.ide_controllers[0] }
            its(['Address']) { should == "1" }
            its(['Description']) { should == "IDE Controller" }
            its(['ElementName']) { should == "IDE 1" }
            its(['InstanceID']) { should == "4" }
            its(['ResourceType']) { should == "5" }
          end
          describe 'ide controller 1' do
            subject { vm.ide_controllers[1] }
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
            subject { vm.scsi_controllers.first }
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
            subject { vm.floppy_drives.first }
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
            subject { vm.optical_drives.first }
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
            subject { vm.network_cards[0] }
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
            subject { vm.network_cards[1] }
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
            subject { vm.network_cards[2] }
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
            subject { vm.network_cards[3] }
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
    let(:ovf) { VmPackage.create('file://spec/fixtures/ComplexVAPP.ovf').fetch }
    subject { ovf }
    it { should be_a_kind_of(FileVmPackage) }
    its(:url) { should eql('spec/fixtures/ComplexVAPP.ovf') }
    its(:uri) { should eql('file://spec/fixtures/ComplexVAPP.ovf') }
    its(:base_path) { should be_nil }
    its(:name) { should eql('ComplexVAPP.ovf') }
    its(:version) { should be_nil }
    its(:protocol) { should == "file" }
    #it { should be_valid }

    describe 'files' do
      it { should have(6).files }
      describe 'file1' do
        subject { ovf.files[0] }
        its(['id']) { should == "file1" }
        its(['href']) { should == "ComplexVAPP-disk1.vmdk" }
        its(['size']) { should == "69632" }
      end
      describe 'file2' do
        subject { ovf.files[1] }
        its(['id']) { should == "file2" }
        its(['href']) { should == "ComplexVAPP-file1.iso" }
        its(['size']) { should == "203423744" }
      end
      describe 'file3' do
        subject { ovf.files[2] }
        its(['id']) { should == "file3" }
        its(['href']) { should == "ComplexVAPP-disk2.vmdk" }
        its(['size']) { should == "70144" }
      end
      describe 'file4' do
        subject { ovf.files[3] }
        its(['id']) { should == "file4" }
        its(['href']) { should == "ComplexVAPP-disk3.vmdk" }
        its(['size']) { should == "72704" }
      end
      describe 'file5' do
        subject { ovf.files[4] }
        its(['id']) { should == "file5" }
        its(['href']) { should == "ComplexVAPP-file2.iso" }
        its(['size']) { should == "203423744" }
      end
      describe 'file6' do
        subject { ovf.files[5] }
        its(['id']) { should == "file6" }
        its(['href']) { should == "ComplexVAPP-disk4.vmdk" }
        its(['size']) { should == "69120" }
      end
    end

    describe 'disks' do
      it { should have(4).disks }
      describe 'vmdisk1' do
        subject { ovf.disks[0] }
        its(['name']) { should == "vmdisk1" }
        its(['location']) { should == "ComplexVAPP-disk1.vmdk" }
        its(['size']) { should == "17179869184" }
        its(['format']) { should == "vmdk" }
      end
      describe 'vmdisk2' do
        subject { ovf.disks[1] }
        its(['name']) { should == "vmdisk2" }
        its(['location']) { should == "ComplexVAPP-disk2.vmdk" }
        its(['size']) { should == "21474836480" }
        its(['format']) { should == "vmdk" }
      end
      describe 'vmdisk3' do
        subject { ovf.disks[2] }
        its(['name']) { should == "vmdisk3" }
        its(['location']) { should == "ComplexVAPP-disk3.vmdk" }
        its(['size']) { should == "42949672960" }
        its(['format']) { should == "vmdk" }
      end
      describe 'vmdisk4' do
        subject { ovf.disks[3] }
        its(['name']) { should == "vmdisk4" }
        its(['location']) { should == "ComplexVAPP-disk4.vmdk" }
        its(['size']) { should == "10737418240" }
        its(['format']) { should == "vmdk" }
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
      it { should have(2).virtual_systems }
      describe 'virtual system 1' do
        let(:vm) { ovf.virtual_systems[0] }
        subject { vm }
        its(:name) { should == "ComplexOVF-VMW-V8" }
        its(:description) { should == ""}
        its(:info) { should == "A virtual machine" }
        its(:operating_system) { should == "Red Hat Enterprise Linux 6 (64-bit)" }
        its(:cpus) { should == 8 }
        its(:memory) { should == 10240 }
        describe 'IDE Controller' do
          it { should have(2).ide_controllers }
          describe 'ide controller 0' do
            subject { vm.ide_controllers[0] }
            its(['Address']) { should == "1" }
            its(['Description']) { should == "IDE Controller" }
            its(['ElementName']) { should == "IDE 1" }
            its(['InstanceID']) { should == "4" }
            its(['ResourceType']) { should == "5" }
          end
          describe 'ide controller 1' do
            subject { vm.ide_controllers[1] }
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
            subject { vm.scsi_controllers.first }
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
            subject { vm.floppy_drives.first }
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
            subject { vm.optical_drives.first }
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
          describe 'disk 1' do
            subject { vm.disks[0] }
            its(['AddressOnParent']) { should == "0" }
            its(['ElementName']) { should == "Hard disk 1" }
            its(['HostResource']) { should == "ovf:/disk/vmdisk1" }
            its(['InstanceID']) { should == "6" }
            its(['Parent']) { should == "3" }
            its(['ResourceType']) { should == "17" }
          end
          describe 'disk 2' do
            subject { vm.disks[1] }
            its(['AddressOnParent']) { should == "1" }
            its(['ElementName']) { should == "Hard disk 2" }
            its(['HostResource']) { should == "ovf:/disk/vmdisk2" }
            its(['InstanceID']) { should == "13" }
            its(['Parent']) { should == "3" }
            its(['ResourceType']) { should == "17" }
          end
        end

        describe 'network cards' do
          it { should have(4).network_cards }
          describe 'network card 1' do
            subject { vm.network_cards[0] }
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
            subject { vm.network_cards[1] }
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
            subject { vm.network_cards[2] }
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
            subject { vm.network_cards[3] }
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
      describe 'virtual system 2' do
        let(:vm) { ovf.virtual_systems[1] }
        subject { vm }
        its(:name) { should == "ComplexOVF-VMW-V7" }
        its(:info) { should == "A virtual machine" }
        its(:operating_system) { should == "Microsoft Windows Server 2008 R2 (64-bit)" }
        its(:cpus) { should == 4 }
        its(:memory) { should == 4096 }
        describe 'IDE Controller' do
          it { should have(2).ide_controllers }
          describe 'ide controller 0' do
            subject { vm.ide_controllers[0] }
            its(['Address']) { should == "1" }
            its(['Description']) { should == "IDE Controller" }
            its(['ElementName']) { should == "IDE 1" }
            its(['InstanceID']) { should == "4" }
            its(['ResourceType']) { should == "5" }
          end
          describe 'ide controller 1' do
            subject { vm.ide_controllers[1] }
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
            subject { vm.scsi_controllers.first }
            its(['Address']) { should == "0" }
            its(['Description']) { should == "SCSI Controller" }
            its(['ElementName']) { should == "SCSI controller 0" }
            its(['InstanceID']) { should == "3" }
            its(['ResourceSubType']) { should == "lsilogicsas" }
            its(['ResourceType']) { should == "6" }
          end
        end

        describe 'floppy drives' do
          it { should have(1).floppy_drives }
          describe 'floppy drive 1' do
            subject { vm.floppy_drives.first }
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
            subject { vm.optical_drives.first }
            its(['AddressOnParent']) { should == "0" }
            its(['AutomaticAllocation']) { should == "true" }
            its(['ElementName']) { should == "CD/DVD drive 1" }
            its(['HostResource']) { should == "ovf:/file/file5" }
            its(['Parent']) { should == "4" }
            its(['InstanceID']) { should == "7" }
            its(['ResourceType']) { should == "15" }
          end
        end

        describe 'disks' do
          it { should have(2).disks }
          describe 'disk 1' do
            subject { vm.disks[0] }
            its(['AddressOnParent']) { should == "0" }
            its(['ElementName']) { should == "Hard disk 1" }
            its(['HostResource']) { should == "ovf:/disk/vmdisk3" }
            its(['InstanceID']) { should == "6" }
            its(['Parent']) { should == "3" }
            its(['ResourceType']) { should == "17" }
          end
          describe 'disk 2' do
            subject { vm.disks[1] }
            its(['AddressOnParent']) { should == "1" }
            its(['ElementName']) { should == "Hard disk 2" }
            its(['HostResource']) { should == "ovf:/disk/vmdisk4" }
            its(['InstanceID']) { should == "13" }
            its(['Parent']) { should == "3" }
            its(['ResourceType']) { should == "17" }
          end
        end
        describe 'network cards' do
          it { should have(4).network_cards }
          describe 'network card 1' do
            subject { vm.network_cards[0] }
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
            subject { vm.network_cards[1] }
            its(['AddressOnParent']) { should == "8" }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "VINET02" }
            its(['Description']) { should == "VmxNet2 ethernet adapter on \"VINET02\"" }
            its(['ElementName']) { should == "Network adapter 2" }
            its(['InstanceID']) { should == "9" }
            its(['ResourceSubType']) { should == "VmxNet2" }
            its(['ResourceType']) { should == "10" }
          end
          describe 'network card 3' do
            subject { vm.network_cards[2] }
            its(['AddressOnParent']) { should == "9" }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "VINET03" }
            its(['Description']) { should == "E1000 ethernet adapter on \"VINET03\"" }
            its(['ElementName']) { should == "Network adapter 3" }
            its(['InstanceID']) { should == "10" }
            its(['ResourceSubType']) { should == "E1000" }
            its(['ResourceType']) { should == "10" }
          end
          describe 'network card 4' do
            subject { vm.network_cards[3] }
            its(['AddressOnParent']) { should == "10" }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "VINET04" }
            its(['Description']) { should == "VmxNet3 ethernet adapter on \"VINET04\"" }
            its(['ElementName']) { should == "Network adapter 4" }
            its(['InstanceID']) { should == "11" }
            its(['ResourceSubType']) { should == "VmxNet3" }
            its(['ResourceType']) { should == "10" }
          end

        end

        it { should have(0).other_configurations }
      end
    end


    describe 'annotations' do
      it { should have(1).annotations }
      describe 'first annotation' do
        subject { ovf.annotations.first }
        it { should == "Created by vSphere 5.0\nvApp Containing two Virtual Machines\nEach virtual machine has Version 7 and version 8 Hardware" }
      end
    end
  end

  describe 'xen-vyatta.ovf' do
    let(:ovf) { VmPackage.create('file://spec/fixtures/xen-vyatta.ovf').fetch }
    subject { ovf }
    it { should be_a_kind_of(FileVmPackage) }
    its(:url) { should eql('spec/fixtures/xen-vyatta.ovf') }
    its(:uri) { should eql('file://spec/fixtures/xen-vyatta.ovf') }
    its(:base_path) { should be_nil }
    its(:name) { should eql('xen-vyatta.ovf') }
    its(:version) { should == "1.0.0" }
    its(:protocol) { should == "file" }

    describe 'files' do
      it { should have(1).files }
      describe 'file 1' do
        subject { ovf.files[0] }
        its(['id']) { should == "d7a869a5-2ac9-4839-9210-e645d9cf1924" }
        its(['href']) { should == "0163f260-330b-43d1-adbd-bbcb038fdab2.vhd" }
        its(['size']) { should == "207229581" }
      end
    end

    describe 'disks' do
      it { should have(1).disks }
      describe 'disk 1' do
        subject { ovf.disks[0] }
        its(['name']) { should == "d7a869a5-2ac9-4839-9210-e645d9cf1924" }
        its(['size']) { should == "21474836480" }
        its(['location']) { should == "0163f260-330b-43d1-adbd-bbcb038fdab2.vhd" }
        its(['format']) { should == "vhd" }
      end
    end

    describe 'virtual_systems' do
      it { should have(1).virtual_systems }
      describe 'first virtual systems' do
        let(:vm) { ovf.virtual_systems.first }
        subject { vm }
        its(:name) { should == "demo2-fw" }
        its(:info) { should == "XenOVF Generated" }
        its(:description) { should == "Imported from an OVF/OVA package."}
        its(:operating_system) { should == "XenOVF Created Export" }
        its(:cpus) { should == 1 }
        its(:memory) { should == 1024 }
        describe 'storage extents' do
          it { should have(1).storage_extents }
          describe 'extent 1' do
            subject { vm.storage_extents[0] }
            its(['ElementName']) { should == "Hard Disk 1" }
            its(['Connection']) { should == 'd7a869a5-2ac9-4839-9210-e645d9cf1924,device=0' }
            its(['HostResource']) { should == "ovf:/disk/d7a869a5-2ac9-4839-9210-e645d9cf1924" }
            its(['InstanceID']) { should == "d7a869a5-2ac9-4839-9210-e645d9cf1924" }
            its(['ResourceSubType']) { should == 'Virtual Hard Disk Image' }
            its(['ResourceType']) { should == "19" }
          end
        end
        describe 'network cards' do
          it { should have(2).network_cards }
          describe 'network card 1' do
            subject { vm.network_cards[0] }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "253c72df-fdc5-7a43-fb7f-3d69370f3539" }
            its(['ElementName']) { should == "VINET01" }
            its(['InstanceID']) { should == "0c652713-b098-45f1-9b86-538fa9eeb9a4" }
            its(['ResourceType']) { should == "10" }
          end
          describe 'network card 2' do
            subject { vm.network_cards[1] }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "253c72df-fdc5-7a43-fb7f-3d69370f3539" }
            its(['ElementName']) { should == "VINET01" }
            its(['InstanceID']) { should == "5e072139-c72d-450e-87ae-5e029b8d8437" }
            its(['ResourceType']) { should == "10" }
          end
        end

        describe 'other configurations' do
          it { should have(3).other_configurations }
          describe 'configurations' do
            subject { vm.other_configurations }
            its(['HVM_boot_params']) { should == "dc" }
            its(['HVM_boot_policy']) { should == "BIOS order" }
            its(['platform']) { should == "apic=true;stdvga=0;acpi=true;pae=true;" }
          end
        end
      end
    end
  end

  describe 'stress-utf8.ovf' do
    let(:ovf) { VmPackage.create('file://spec/fixtures/stress-utf8.ovf').fetch }
    subject { ovf }
    it { should be_a_kind_of(FileVmPackage) }
    its(:url) { should eql('spec/fixtures/stress-utf8.ovf') }
    its(:uri) { should eql('file://spec/fixtures/stress-utf8.ovf') }
    its(:base_path) { should be_nil }
    its(:name) { should eql('stress-utf8.ovf') }
    its(:version) { should == "1.0.0" }
    its(:protocol) { should == "file" }

    describe 'files' do
      it { should have(1).files }
      describe 'file 1' do
        subject { ovf.files[0] }
        its(['id']) { should == "d800ee77-7353-47f9-9699-5155470c34b3" }
        its(['href']) { should == "b019b48a-3779-4fbf-acb2-8bb9a5858eea.vhd" }
        its(['size']) { should == "3905239655" }
      end
    end

    describe 'disks' do
      it { should have(1).disks }
      describe 'disk 1' do
        subject { ovf.disks[0] }
        its(['name']) { should == "d800ee77-7353-47f9-9699-5155470c34b3" }
        its(['size']) { should == "8589934592" }
        its(['location']) { should == "b019b48a-3779-4fbf-acb2-8bb9a5858eea.vhd" }
        its(['format']) { should == "vhd" }
      end
    end

    describe 'virtual_systems' do
      it { should have(1).virtual_systems }
      describe 'first virtual systems' do
        let(:vm) { ovf.virtual_systems.first }
        subject { vm }
        its(:name) { should == "stress" }
        its(:description) { should == "minimal centos 6.2 with chef"}
        its(:info) { should == "XenOVF Generated" }
        its(:operating_system) { should == "CentOS release 6.2 (Final)" }
        its(:cpus) { should == 1 }
        its(:memory) { should == 1024 }
        describe 'storage extents' do
          it { should have(1).storage_extents }
          describe 'extent 1' do
            subject { vm.storage_extents[0] }
            its(['ElementName']) { should == "centos-6_2-minimal-chef 0" }
            its(['Connection']) { should == 'd800ee77-7353-47f9-9699-5155470c34b3,device=0' }
            its(['HostResource']) { should == "ovf:/disk/d800ee77-7353-47f9-9699-5155470c34b3" }
            its(['InstanceID']) { should == "d800ee77-7353-47f9-9699-5155470c34b3" }
            its(['ResourceSubType']) { should == 'Virtual Hard Disk Image' }
            its(['ResourceType']) { should == "19" }
          end
        end
        describe 'network cards' do
          it { should have(2).network_cards }
          describe 'network card 1' do
            subject { vm.network_cards[0] }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "cde46fea-5e39-71ac-4f5d-155429a1c049" }
            its(['ElementName']) { should == "Pool-wide network associated with eth0" }
            its(['InstanceID']) { should == "eae8c695-0f80-4ff6-b4e4-5f5cd480b3bc" }
            its(['ResourceType']) { should == "10" }
          end
          describe 'network card 2' do
            subject { vm.network_cards[1] }
            its(['AutomaticAllocation']) { should == "true" }
            its(['Connection']) { should == "8f74bf33-13d7-2203-1b25-07e83bd15336" }
            its(['ElementName']) { should == "Pool-wide network associated with eth1" }
            its(['InstanceID']) { should == "6685f92c-6a79-4c1a-a88b-2fbfd6b34455" }
            its(['ResourceType']) { should == "10" }
          end
        end

        describe 'other configurations' do
          it { should have(3).other_configurations }
          describe 'configurations' do
            subject { vm.other_configurations }
            its(['PV_args']) { should == "graphical utf8" }
            its(['PV_bootloader']) { should == "pygrub" }
            its(['platform']) { should == "nx=false;viridian=true;acpi=true;pae=true;apic=true;" }
          end
        end
      end
    end
  end
end