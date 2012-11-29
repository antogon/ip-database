class IpDropV6Partition < ActiveRecord::Migration
  def up
		remove_column :ip_addresses, :ip_v6_1
		remove_column :ip_addresses, :ip_v6_2
		add_column :ip_addresses, :ip_v6, 'BIGINT UNSIGNED', :limit => 128
  end

  def down
		remove_column :ip_addresses, :ip_v6
		add_column :ip_addresses, :ip_v6_1, 'BIGINT UNSIGNED', :limit => 20
		add_column :ip_addresses, :ip_v6_2, 'BIGINT UNSIGNED', :limit => 20
  end
end
