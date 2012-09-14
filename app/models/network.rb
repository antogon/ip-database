class Network < ActiveRecord::Base
  attr_accessible :id,:name, :creator_id, :updater_id,
		:router_name, :is_vrf, :is_hsrp, :desc, :vlan_no, :created_at, :updated_at
	has_many :ip_addresses, :class_name => 'IPAddress', :foreign_key => :network_parent
	has_one :network_no, :class_name => 'IPAddress', :primary_key => :network_no, :foreign_key => :id
	has_one :netmask, :class_name => 'IPAddress', :primary_key => :netmask, :foreign_key => :id
end
