require 'spec_helper'

describe VmPackage do
  describe 'ourOVF.ovf' do
    subject { VmPackage.create('file://fixtures/ourOVF.ovf').fetch }
    it {should be_a_kind_of(FileVmPackage)}



  end


end