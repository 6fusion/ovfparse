module Ovfparse
  class OVF
    def self.parse(uri)
      VmPackage.create(uri).fetch
    end
  end
end

