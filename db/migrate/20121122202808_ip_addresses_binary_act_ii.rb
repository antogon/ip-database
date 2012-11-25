class IpAddressesBinaryActIi < ActiveRecord::Migration
  def up
		remove_column :ip_addresses, :ip_v4
		remove_column :ip_addresses, :ip_v6
		add_column :ip_addresses, :ip_v4, 'BINARY(8)', :null => true
		add_column :ip_addresses, :ip_v6, 'BINARY(32)', :null => true
  end

  def down
		remove_column :ip_addresses, :ip_v4
		remove_column :ip_addresses, :ip_v6
		add_column :ip_addresses, :ip_v4, 'BINARY(4)', :null => true
		add_column :ip_addresses, :ip_v6, 'BINARY(16)', :null => true
  end
end
