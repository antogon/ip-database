class IpAddress < ActiveRecord::Base
	belongs_to :network, :foreign_key => 'network_parent'
	has_one :type, :class_name => 'DeviceType', :foreign_key => "id", :primary_key => "device_type"
	has_many :dns_devices, :class_name => 'DnsDeviceAssoc', :foreign_key => 'ip_id'

	def has_parent?
		!self.network.nil?
	end

	def ip_v4?
		i = read_attribute(:ip_v6)
		i==0 || i.nil?
	end

	def ip_v6?
		i = read_attribute(:ip_v4)
		i==0 || i.nil?
	end

	def ip_v4= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:ip_v4, ip.to_i)
	end
	
	def ip_v4
		IP.new(['v4',read_attribute(:ip_v4)]).to_s
	end

	def ip_v6= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:ip_v6, ip.to_i.to_s)
	end
	
	def ip_v6
		IP.new(['v6',read_attribute(:ip_v6).to_i.to_s(16)])
	end
end
