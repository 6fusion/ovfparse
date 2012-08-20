module Ovfparse
  class OVF
    # Retrieve an ovf from a uri and parse it
    # @param [String] uri
    # @return [VmPackage]
    def self.parse(uri)
      VmPackage.create(uri).fetch
    end

    # load an ovf from raw xml
    # @param [String] xml
    # @return [VmPackage]
    def self.from_xml(xml)
      ovf = VmPackage.new
      ovf.xml = Nokogiri::XML(xml) do |config|
            config.noblanks.strict.noent
      end
      ovf.fetch
    end
  end
end

