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
  attr_accessible :id,:name, :creator_id, :updater_id, :network_no, :netmask, :network_parent, :ip_v4,
		:router_name, :is_vrf, :is_hsrp, :desc, :vlan_no, :created_at, :updated_at
	has_many :ip_addresses, :class_name => 'IpAddress', :foreign_key => :network_parent
	has_many :dhcp_ranges, :class_name => 'DhcpRange', :foreign_key => :network_parent
	has_one :parent, :class_name => 'Network', :primary_key => :network_parent, :foreign_key => :id

	scope :ip_in_range?, lambda { |ip| 
		ip = IP.parse(ip)
		Network.all.delete_if { |x| (!x.assignable? ip) }
	}

	def assignable? ip
		mask = IP.parse(self.netmask).to_i.to_s(2).split(//).inject(0) { |s,i| s + i.to_i }
		mask = ((self.ip_v4)?32:128)-mask
		(((IP.parse(self.network_no))..(IP.new([(self.ip_v4)?"v4":"v6",IP.parse(self.network_no).to_i | [((2**mask)-1).to_s(16).rjust((self.ip_v4)?8:32,'0').scan(/[0-9a-f]{2}/i).reverse.join].pack('H*').unpack('l')[0]]))) === ip) &&
		!(self.ip_addresses.collect {|x| x.ip_str}.include? ip.to_s) &&
		self.dhcp_ranges.delete_if {|x| !(x.to_range === ip)}.length == 0
	end
	#Protects the private parts	
	def ip_v4=
		raise "You can't set this.  It's read-only.  Asshole."
	end

	# Returns the network to which it is a parent
	def child_networks
		Network.where(:network_parent => self.id)
	end

	# Assignment override setting values for the network
	def network_no= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:ip_v4, (ip.proto=="v4"))
		write_attribute(:network_no, ip.to_hex)
	end
	# Getting values for the network in string representation
	def network_no
		addr = read_attribute(:network_no)
		IP.new([(read_attribute(:ip_v4))?"v4":"v6",addr]).to_s
	end
	# Assignment override setting values for the netmask
	def netmask= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:netmask, ip.to_hex)
	end
	# Getting values for the netmask in string representation
	def netmask
		addr = read_attribute(:netmask)
		IP.new([(read_attribute(:ip_v4))?"v4":"v6",addr]).to_s
	end
	#Returns number of static IP Adresses of a subnet or a supernet
	def num_static_ip
		total = 0
		if self.child_networks == [] #If subnet
			total+=self.ip_addresses.length
		else # else if supernet
			self.child_networks.each {|child| total+=child.num_static_ip}
		end
		total
	end
	#Returns number IP Addresses in DHCP Ranges for a subnet or a supernet
	def num_dhcp_ranges
		total = 0
		if self.child_networks == [] #If subnet
			self.dhcp_ranges.each {|dhcp| total+=dhcp.address_count}
		else #else if supernet
			self.child_networks.each {|child| total+=child.num_dhcp_ranges}
		end
		total
	end

	#Returns the number of IP Addresses/DHCP Range Sizes in a network
	#Or returns the same for all child networks
	def num_ip_assigned
		self.num_static_ip + self.num_dhcp_ranges
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

	def order
		 self.dhcp_ranges.to_a.concat(self.ip_addresses.to_a).sort! {|a,b| a = (a.class.name=="DhcpRange")? a.start_ip: a.ip_str; b = (b.class.name=="DhcpRange")? b.start_ip : b.ip_str; IP.parse( a ) <=> IP.parse( b )}
	end

	def frag_array
		data = self.order
		net_no = (IP.new(self.network_no)).to_i
		loc = net_no
		i = 0
		while i < data.length
			store = data[i].ip_a
			i+=1
		end
	end
end
