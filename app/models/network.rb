class Network < ActiveRecord::Base
  attr_accessible :id,:name, :creator_id, :updater_id, :network_no, :netmask, :network_parent,
		:router_name, :is_vrf, :is_hsrp, :desc, :vlan_no, :created_at, :updated_at
	has_many :ip_addresses, :class_name => 'IpAddress', :foreign_key => :network_parent
	has_one :parent, :class_name => 'Network', :primary_key => :network_parent, :foreign_key => :id

	def child_networks
		Network.where(:network_parent => self.id)
	end

	def network_no= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:network_no, ip.to_s)
	end
	
	def network_no
		addr = read_attribute(:network_no)
		IP.parse(addr).to_s
	end

	def netmask= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:netmask, ip.to_s)
	end
	
	def netmask
		addr = read_attribute(:netmask)
		IP.parse(addr).to_s
	end

	def num_ip
		curr_net = self
		i = 0
		num_ips = 0
		if curr_net.ip_addresses.length != 0
			num_ips += curr_net.ip_addresses.length
		else
			while i < curr_net.child_networks.length
				num_ips = num_ips + curr_net.child_networks[i].num_ip
				i = i + 1
			end
		end

		num_ips
	end
end
