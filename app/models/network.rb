class Network < ActiveRecord::Base
  attr_accessible :id,:name, :creator_id, :updater_id,
		:router_name, :is_vrf, :is_hsrp, :desc, :vlan_no, :created_at, :updated_at
	has_many :ip_addresses, :class_name => 'IpAddress', :foreign_key => :network_parent
	has_one :network_ip, :class_name => 'IpAddress', :primary_key => :network_no, :foreign_key => :id
	has_one :netmask_ip, :class_name => 'IpAddress', :primary_key => :netmask, :foreign_key => :id
end
