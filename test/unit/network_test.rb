# == Schema Information
#
# Table name: networks
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  creator_id     :string(255)      not null
#  updater_id     :string(255)
#  router_name    :string(255)
#  is_vrf         :boolean          default(FALSE), not null
#  is_hsrp        :boolean          default(FALSE), not null
#  desc           :text
#  vlan_no        :integer
#  network_parent :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  network_no     :string(255)      not null
#  netmask        :string(255)      not null
#

require 'test_helper'

class NetworkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
