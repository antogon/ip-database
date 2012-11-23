class DhcpRangesToBinary < ActiveRecord::Migration
  def up
		remove_column :dhcp_ranges, :start_ip
		remove_column :dhcp_ranges, :end_ip
		add_column :dhcp_ranges, :start_ip, 'BINARY(32)', :null => false
		add_column :dhcp_ranges, :end_ip, 'BINARY(32)', :null => false
		add_column :dhcp_ranges, :ip_v4, :boolean, :null => false
  end

  def down
		remove_column :dhcp_ranges, :start_ip
		remove_column :dhcp_ranges, :end_ip
		remove_column :dhcp_ranges, :ip_v4
		add_column :dhcp_ranges, :start_ip, :string, :null => false, :limit => 255
		add_column :dhcp_ranges, :end_ip, :string, :null => false, :limit => 255
  end
end
