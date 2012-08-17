class VirtualSystem

  RESOURCE_TYPES = {
    :cpu      => 3,
    :memory   => 4,
    :ide      => 5,
    :scsi     => 6,
    :ethernet => 10,
    :floppy   => 14,
    :cd       => 15,
    :dvd      => 16,
    :disk     => 17,
    :usb      => 23
  }

  attr_accessor :xml

  def initialize(_xml)
    self.xml              = _xml


  end

#  protected

  def name
    @name ||= self.xml['id']
  end

  def info
    @info ||= (self.xml.at('.//Info')).text
  end

  def optical_drives
    @optiical_drives ||= (hardware_resource(:cd) + hardware_resource(:dvd)).map do |disk|
      Hash[*disk.element_children.map { |x| [x.name, x.text] }.flatten]
    end
  end

  def disks
    @disks ||= (hardware_resources(:disk)).map do |disk|
      Hash[*disk.element_children.map { |x| [x.name, x.text] }.flatten]
    end
  end

  def network_cards
    @network_cards ||= (hardware_resources(:ethernet)).map do |ethernet|
      Hash[*ethernet.element_children.map { |x| [x.name, x.text] }.flatten]
    end
  end

  def cpus
    @cpus ||= (hardware_resource(:cpu)/'VirtualQuantity').text.to_i
  end

  def memory
    @memory ||= (hardware_resource(:memory)/'VirtualQuantity').text.to_i
  end

  def operating_system
    @operating_system ||= (self.xml/'OperatingSystemSection/Description').text
  end

  protected

  def hardware
    self.xml/'VirtualHardwareSection'
  end

  def hardware_resource(id)
    (self.hardware.at("Item/ResourceType[text()='#{RESOURCE_TYPES[id]}']")).parent
  end

  def hardware_resources(id)
    (self.hardware.xpath("Item/ResourceType[text()='#{RESOURCE_TYPES[id]}']")).map do |node|
      node.parent
    end
  end


end