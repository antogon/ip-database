# == Schema Information
#
# Table name: dns_device_assocs
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  ip_id      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DnsDeviceAssoc < ActiveRecord::Base
  attr_accessible :id, :name, :ip_id
	belongs_to :ip_address, :class_name => 'IpAddress', :foreign_key => 'ip_id', :primary_key => 'id'
end
