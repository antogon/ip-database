# == Schema Information
#
# Table name: dhcp_ranges
#
#  id             :integer          not null, primary key
#  start_ip       :string(255)      not null
#  end_ip         :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  network_parent :integer
#
#
# The Dynamic Host Configuration Protocol (DHCP) is a network protocol that is used to configure network devices 
# so that they can communicate on an IP network. 
# A DHCP client uses the DHCP protocol to acquire configuration information, such as an IP address, a default route 
# and one or more DNS server addresses from a DHCP server. 
# The DHCP client then uses this information to configure its host. Once the configuration process is complete, 
# the host is able to communicate on the internet.

# Acquire IP addresses to configure the host class
class DhcpRange < ActiveRecord::Base
	# Acquire IP addresses to configure the host
  attr_accessible :start_ip, :end_ip, :id, :created_at, :updated_at, :network_parent
	belongs_to :network, :foreign_key => 'network_parent'

	# returns number of addresses in range
	def address_count
		IP.parse(read_attribute(:end_ip)).to_i - IP.parse(read_attribute(:start_ip)).to_i + 1
	end
        # Assignment of the string the Start Ip for the database
	def start_ip= attr
		ip = IP.parse(attr)
		write_attribute(:start_ip, ip.to_s) 
	end
	# Returns the string representation of the Start IP
	def start_ip
		ip = IP.parse(read_attribute(:start_ip))
		ip.to_s
	end
        # Assignment of the string the End Ip for the database

	def end_ip= attr
		ip = IP.parse(attr)
		write_attribute(:end_ip, ip.to_s) 
	end
        # Returns the string representation of the End IP
	def end_ip
		ip = IP.parse(read_attribute(:end_ip))
		ip.to_s
	end
end
