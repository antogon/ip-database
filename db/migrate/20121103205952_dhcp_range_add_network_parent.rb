class DhcpRangeAddNetworkParent < ActiveRecord::Migration
  def up
		add_column :dhcp_ranges, :network_parent, :integer, :null => true
  end

  def down
		remove_column :dhcp_ranges, :network_parent
  end
end
