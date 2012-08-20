require 'spec_helper'

describe Ovfparse::OVF do
  describe ".parse(uri)" do
    let(:ovf) { mock('ovf', :fetch => true)}
    before(:each) do
      VmPackage.stub(:create).and_return(ovf)
    end

    it 'should create a VmPackage' do
      VmPackage.should_receive(:create).and_return(ovf)
      Ovfparse::OVF.parse('file://ovf')
    end
  end
end