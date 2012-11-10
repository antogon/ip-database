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

require 'test_helper'

class DhcpRangeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
