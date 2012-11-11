class DnsDeviceAssoc < ActiveRecord::Base
  attr_accessible :id, :name, :ip_id
	has_many :dns_ip_joins, :foreign_key => :dns_id
	has_many :ip_addresses, :through => :dns_ip_joins
end
