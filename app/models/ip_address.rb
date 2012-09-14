class IPAddress < ActiveRecord::Base
	belongs_to :network, :foreign_key => 'network_parent'

	def ip_v4= new_ip
		ip = IP.new(new_ip)
		write_attribute(:ip_v4, ip.to_i)
	end
	
	def ip_v4
		IP.new(['v4',read_attribute(:ip_v4)]).to_s
	end
end
