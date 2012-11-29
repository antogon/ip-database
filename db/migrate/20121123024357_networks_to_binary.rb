class NetworksToBinary < ActiveRecord::Migration
  def up
		remove_column :networks, :network_no
		remove_column :networks, :netmask
		add_column :networks, :network_no, 'BINARY(32)', :null => false
		add_column :networks, :netmask, 'BINARY(32)', :null => false
		add_column :networks, :ip_v4, :boolean, :null => false
  end

  def down
		remove_column :networks, :network_no
		remove_column :networks, :netmask
		remove_column :networks, :ip_v4
		add_column :networks, :network_no, :string, :null => false, :limit => 255
		add_column :networks, :netmask, :string, :null => false, :limit => 255
  end
end
