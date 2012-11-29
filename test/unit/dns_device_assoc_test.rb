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

require 'test_helper'

class DnsDeviceAssocTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
