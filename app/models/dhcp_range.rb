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

class DhcpRange < ActiveRecord::Base
  attr_accessible :start_ip, :end_ip, :id, :created_at, :updated_at, :network_parent
	belongs_to :network, :foreign_key => 'network_parent'

	# returns number of addresses in range
	def address_count
		IP.parse(read_attribute(:end_ip)).to_i - IP.parse(read_attribute(:start_ip)).to_i + 1
	end

	def start_ip= attr
		ip = IP.parse(attr)
		write_attribute(:start_ip, ip.to_s) 
	end

	def start_ip
		ip = IP.parse(read_attribute(:start_ip))
		ip.to_s
	end

	def end_ip= attr
		ip = IP.parse(attr)
		write_attribute(:end_ip, ip.to_s) 
	end

	def end_ip
		ip = IP.parse(read_attribute(:end_ip))
		ip.to_s
	end
end
