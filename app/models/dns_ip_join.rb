class DnsIpJoin < ActiveRecord::Base
	attr_accessible :id, :ip_id, :dns_id
	belongs_to :ip_address, :foreign_key => 'ip_id'
	belongs_to :dns_device, :foreign_key => 'dns_id'
end
