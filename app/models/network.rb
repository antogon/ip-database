# == Schema Information
#
# Table name: networks
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  creator_id     :string(255)      not null
#  updater_id     :string(255)
#  router_name    :string(255)
#  is_vrf         :boolean          default(FALSE), not null
#  is_hsrp        :boolean          default(FALSE), not null
#  desc           :text
#  vlan_no        :integer
#  network_parent :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  network_no     :string(255)      not null
#  netmask        :string(255)      not null
#

class Network < ActiveRecord::Base
  attr_accessible :id,:name, :creator_id, :updater_id, :network_no, :netmask, :network_parent,
		:router_name, :is_vrf, :is_hsrp, :desc, :vlan_no, :created_at, :updated_at
	has_many :ip_addresses, :class_name => 'IpAddress', :foreign_key => :network_parent
	has_many :dhcp_ranges, :class_name => 'DhcpRange', :foreign_key => :network_parent
	has_one :parent, :class_name => 'Network', :primary_key => :network_parent, :foreign_key => :id

	# scope :ip_in_range?, lambda{ |ip| }
	
	# Returns the network to which it is a parent
	def child_networks
		Network.where(:network_parent => self.id)
	end
	# Assignment override setting values for the network
	def network_no= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:network_no, ip.to_s)
	end
	# Getting values for the network in string representation
	def network_no
		addr = read_attribute(:network_no)
		IP.parse(addr).to_s
	end
	# Assignment override setting values for the netmask
	def netmask= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:netmask, ip.to_s)
	end
	# Getting values for the netmask in string representation
	def netmask
		addr = read_attribute(:netmask)
		IP.parse(addr).to_s
	end

	#Returns the number of IP Addresses/DHCP Range Sizes in a network
	#Or returns the same for all child networks
	def num_ip_assigned
		total = 0
		if self.child_networks == [] #If subnet
		 if(self.ip_addresses!=[])
			total += self.ip_addresses.length
		 end
		 self.dhcp_ranges.each {|dhcp| total+=dhcp.address_count}
		else # else if supernet
		 self.child_networks.each {|child| total+=child.num_ip_assigned}
		end
		total
	end

	# Returns total number of the IP addresses within the network
	def num_ip
		 start_ip = IP.parse(self.network_no)
		 mask = IP.parse(self.netmask).to_i.to_s(2).split(//).inject(0) { |s,i| s + i.to_i }
		 IP.new([start_ip.proto, start_ip, mask]).network.size
	end
	# Getting number of IP that are free
	def num_ip_free
		num_ip - num_ip_assigned
	end
end
