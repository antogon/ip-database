class NetworksToVarbinary16 < ActiveRecord::Migration
  def up
		remove_column :networks, :network_no
		remove_column :networks, :netmask
		add_column :networks, :network_no, 'VARBINARY(16)', :null => false
		add_column :networks, :netmask, 'VARBINARY(16)', :null => false
  end

  def down
		remove_column :networks, :network_no
		remove_column :networks, :netmask
		add_column :networks, :network_no, 'BINARY(32)', :null => false
		add_column :networks, :netmask, 'BINARY(32)', :null => false
  end
end
