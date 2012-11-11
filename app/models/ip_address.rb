class IpAddress < ActiveRecord::Base
	belongs_to :network, :foreign_key => 'network_parent'
	has_one :type, :class_name => 'DeviceType', :foreign_key => "id", :primary_key => "device_type"
	has_many :dns_ip_joins, :foreign_key => "ip_id"
	has_many :dns_devices, :class_name => "DnsDeviceAssoc", :through => :dns_ip_joins
	accepts_nested_attributes_for :dns_devices, :reject_if => :rejection_test, :allow_destroy => true

	def rejection_test(attrs)
		ap attrs
		attrs['id'].blank?
	end

	def has_parent?
		!self.network.nil?
	end

	def ip_str
		if ip_v4?
			ip_v4
		elsif ip_v6?
			ip_v6
		end
	end

	def ip_str= ip_in
		ip = IP.parse(ip_in)
		if ip.proto == "v6"
			self.ip_v6 = ip_in
		elsif ip.proto == "v4"
			self.ip_v4 = ip_in
		end
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
		write_attribute(:ip_v6, ip.to_s)
	end
	
	def ip_v6
		IP.parse(read_attribute(:ip_v6)).to_s
	end
end
