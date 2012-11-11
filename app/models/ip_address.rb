# == Schema Information
#
# Table name: ip_addresses
#
#  id             :integer          not null, primary key
#  contact        :string(255)      not null
#  location       :string(255)      not null
#  device_type    :integer          not null
#  network_parent :integer
#  desc           :text
#  is_static_dhcp :boolean          default(FALSE), not null
#  has_dns_assoc  :boolean          default(FALSE), not null
#  mac_address    :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ip_v4          :integer
#  ip_v6          :string(255)
##
#IPv4 is described in IETF publication RFC 791 (September 1981), replacing an earlier definition (RFC 760, January 1980).
#IPv6 is described in Internet standard document RFC 2460, published in December 1998.

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

 	#Returns true if network exists or false if doesn't
	def has_parent?
		!self.network.nil?
	end
 	#Returns string representation of either IP v4 or IP v6
	def ip_str
		if ip_v4?
			ip_v4
		elsif ip_v6?
			ip_v6
		end
	end
	#Assigns value to IP address
	def ip_str= ip_in
		ip = IP.parse(ip_in)
		if ip.proto == "v6"
			self.ip_v6 = ip_in
		elsif ip.proto == "v4"
			self.ip_v4 = ip_in
		end
	end

 	#Checks if the IP v4 version
	def ip_v4?
		i = read_attribute(:ip_v6)
		i==0 || i.nil?
	end
 	#Checks if the IPv6 version
	def ip_v6?
		i = read_attribute(:ip_v4)
		i==0 || i.nil?
	end
 	#Assignment override setting values for the IP v4
	def ip_v4= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:ip_v4, ip.to_i)
	end
 	#Getting values for the IP v4
	def ip_v4
		IP.new(['v4',read_attribute(:ip_v4)]).to_s
	end
 	#Assignment override setting values for the IP v6
	def ip_v6= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:ip_v6, ip.to_s)
	end
	#Getting values for the IP v6
	def ip_v6
		IP.parse(read_attribute(:ip_v6)).to_s
	end
end
