class IpAddressV6Support < ActiveRecord::Migration
  def up
		remove_column :ip_addresses, :ip_v6
		add_column :ip_addresses, :ip_v6, :string, :null=>true
  end

  def down
		remove_column :ip_addresses, :ip_v6
		add_column :ip_addresses, :ip_v6, 'BIGINT UNSIGNED', :limit => 128
  end
end
