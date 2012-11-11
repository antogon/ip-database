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
	has_many :dns_ip_joins, :foreign_key => :dns_id
	has_many :ip_addresses, :through => :dns_ip_joins
end
