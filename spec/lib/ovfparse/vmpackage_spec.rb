require 'spec_helper'

describe VmPackage do
  describe 'someOVF.ovf' do
    subject { VmPackage.create('file://fixtures/someOVF.ovf').fetch }
    it {should be_a_kind_of(FileVmPackage)}
    


  end


end