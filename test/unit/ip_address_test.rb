# == Schema Information
#
# Table name: ip_addresses
#
#  id             :integer          not null, primary key
#  contact        :string(255)      not null
#  location       :string(255)      not null
#  device_type    :integer          not null
#  network_parent :integer
#  desc           :text
#  is_static_dhcp :boolean          default(FALSE), not null
#  has_dns_assoc  :boolean          default(FALSE), not null
#  mac_address    :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ip_v4          :integer
#  ip_v6          :string(255)
#

require 'test_helper'

class IpAddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
