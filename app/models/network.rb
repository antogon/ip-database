class Network < ActiveRecord::Base
  attr_accessible :id,:name, :creator_id, :updater_id,
		:router_name, :is_vrf, :is_hsrp, :desc, :vlan_no, :created_at, :updated_at
	has_many :ip_addresses, :class_name => 'IpAddress', :foreign_key => :network_parent
	has_one :parent, :class_name => 'Network', :foreign_key => :network_parent

	def child_networks
		Network.where(:network_parent => self.id)
	end

	def network_no= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:network_no, ip.to_i.to_s)
	end
	
	def network_no
		addr = read_attribute(:network_no).to_i
		if addr > 4294967295
			IP.new(['v6',addr.to_i.to_s(16)]).to_s
		else
			IP.new(['v4',addr]).to_s
		end
	end

	def netmask= new_ip
		ip = IP.parse(new_ip)
		write_attribute(:netmask, ip.to_i.to_s)
	end
	
	def netmask
		addr = read_attribute(:netmask).to_i
		if addr > 4294967295
			IP.new(['v6',addr.to_i.to_s(16)]).to_s
		else
			IP.new(['v4',addr]).to_s
		end
	end
end
