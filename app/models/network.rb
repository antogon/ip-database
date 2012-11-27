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
print ip
		ip = IP.parse(ip)
		Network.all.delete_if { |x| (!x.assignable? ip) }
	}

	def valid_network? 
		#Tests if parent is_vrf and self is_vrf match
		if self.parent != nil
			if self.parent.is_vrf^self.is_vrf
				false
			end
		end
		true
	end

	def assignable? ip
		if(self.child_networks.length != 0)
			return false;
		end
		if(((self.ip_v4?)^(ip.proto=="v4")))
			return false;
		end
		mask = IP.parse(self.netmask);
		net = IP.parse(self.network_no);
		if((ip & mask.to_i) == net)
			return true;
		else
			return false;
		end
#		mask = IP.parse(self.netmask).to_i.to_s(2).split(//).inject(0) { |s,i| s + i.to_i }
#		mask = ((self.ip_v4)?32:128)-mask
#		(((IP.parse(self.network_no))..(IP.new([(self.ip_v4)?"v4":"v6",IP.parse(self.network_no).to_i | [((2**mask)-1).to_s(16).rjust((self.ip_v4)?8:32,'0').scan(/[0-9a-f]{2}/i).reverse.join].pack('H*').unpack('l')[0]]))) === ip) &&
#		!(self.ip_addresses.collect {|x| x.ip_str}.include? ip.to_s) &&
#		self.dhcp_ranges.delete_if {|x| !(x.to_range === ip)}.length == 0
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
		ip_loc = 0
		index_loc = -1
		i = 0
		ip_a = []
		frag_num = []
		frag_type = []
		store = 0
                splits = []
		#splits[index_loc+1] = self.network_no
		while i < data.length
			if (data[i].respond_to? :start_ip)
				store = IP.new(data[i].start_ip)
				ip_a[0] = store.to_i-net_no
				ip_a[1] = data[i].address_count
				ip_a[2] = 2
			else
				if(data[i].ip_v4?)
					store = IP.new(data[i].ip_v4)
					ip_a[0] = store.to_i-net_no
				else
					store = IP.new(data[i].ip_v6)
					ip_a[0] = store.to_i-net_no
				end
				ip_a[1] = 1
				ip_a[2] = 3
			end
			if ip_a[0]-ip_loc == 0  #Things are side by side
				if index_loc != -1 && frag_type[index_loc] == ip_a[2] #Things are the same
					frag_num[index_loc]+=ip_a[1]
				else #Things are different
					index_loc+=1
					frag_num[index_loc]=ip_a[1]
					frag_type[index_loc]=ip_a[2]
					splits[index_loc] = store.to_s	#
				end
			elsif ip_a[0]-ip_loc > 0 #There is free space
				index_loc+=1
				frag_num[index_loc]=ip_a[0]-ip_loc
				frag_type[index_loc]=1
				splits[index_loc] = (IP.new(self.network_no) + ip_loc).to_s	#
				index_loc+=1
				frag_num[index_loc]=ip_a[1]
				frag_type[index_loc]=ip_a[2]
				splits[index_loc] = store.to_s	#
			end
			ip_loc = ip_a[0]+ip_a[1]
			i+=1
		end
		if ip_loc < self.num_ip
			index_loc+=1
			frag_num[index_loc]=self.num_ip-ip_loc
			frag_type[index_loc]=1
			splits[index_loc] = (IP.new(self.network_no) + ip_loc).to_s	#
		end
		splits[index_loc+1] = (IP.new(network_no)+num_ip).to_s
		return frag_num, frag_type, splits
	end
end
