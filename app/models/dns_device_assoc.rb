class DnsDeviceAssoc < ActiveRecord::Base
  attr_accessible :id, :name, :ip_id
	belongs_to :ip_address, :class_name => 'IPAddress', :foreign_key => 'ip_id', :primary_key => 'id'
end
