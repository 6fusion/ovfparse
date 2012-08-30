class VirtualSystem

  # http://blogs.vmware.com/vapp/2009/11/virtual-hardware-in-ovf-part-1.html
  RESOURCE_TYPES = {
    :cpu              => 3,
    :memory           => 4,
    :ide_controllers  => 5,
    :scsi_controllers => 6,
    :network_cards    => 10,
    :floppy_drives    => 14,
    :cd_drives        => 15,
    :dvd_drives       => 16,
    :disks            => 17,
    :storage_extents  => 19,
    :usb              => 23
  }

  attr_accessor :xml

  def initialize(_xml)
    self.xml = _xml
  end

  (RESOURCE_TYPES.keys - [:cpu, :memory]).each do |resource|
    define_method(resource.to_sym) do
      (hardware_resources(resource)).map do |r|
        Hash[*r.element_children.map { |x| [x.name, x.text] }.flatten]
      end
    end
  end

  # Get the name of the virtual system
  # many ovfs use the 'id' of the virtual system to hold the name of the machine
  # Xen, on the other hand, adds a 'Name' element
  def name
    @name ||= (self.xml.at('Name').text rescue self.xml['id'])
  end

  def description
    @description ||= ((self.xml.at('System/Description')).text) rescue ""
  end

  def info
    @info ||= ((self.xml.at('Info')).text) rescue ""
  end

  def optical_drives
    @optical_drives ||= cd_drives + dvd_drives
  end

  def cpus
    @cpus ||= (hardware_resources(:cpu).first.at('VirtualQuantity', { })).text.to_i
  end

  def memory
    @memory ||= (hardware_resources(:memory).first.at_xpath('VirtualQuantity')).text.to_i
  end

  def operating_system
    @operating_system ||= (self.xml/'OperatingSystemSection/Description').text
  end

  def product_sections

  end

  def other_configurations
    configs = {}
    (self.xml/'VirtualSystemOtherConfigurationData').map do |node|
        configs[node['Name']] = node.at('Value').text
    end
    configs
  end

  protected

  def hardware
    #self.xml.document.fragment(self.xml.at('VirtualHardwareSection').to_s)
    (self.xml.at('VirtualHardwareSection'))
  end

  def hardware_resources(id)
    found  = self.hardware.xpath("Item/ResourceType[text()='#{RESOURCE_TYPES[id]}']")
    result = []
    found.each do |node|
      result << node.parent
    end
    result
  end


end