class IpAddress < ActiveRecord::Base
	belongs_to :network, :foreign_key => 'network_parent'
	has_one :device_type, :foreign_key => 'id'
	has_many :dns_devices, :class_name => 'DnsDeviceAssoc', :foreign_key => 'ip_id'

	def ip_v4= new_ip
		ip = IP.new(new_ip)
		write_attribute(:ip_v4, ip.to_i)
	end
	
	def ip_v4
		IP.new(['v4',read_attribute(:ip_v4)]).to_s
	end

	def ip_v6= new_ip
		ip = IP.new(new_ip)
		write_attribute(:ip_v6, ip.to_i)
	end
	
	def ip_v6
		IP.new(['v6',read_attribute(:ip_v6)]).to_s
	end
end
