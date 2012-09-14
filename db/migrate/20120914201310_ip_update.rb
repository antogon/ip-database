class IpUpdate < ActiveRecord::Migration
  def up
		add_column :ip_addresses, :ip_v4, 'INT UNSIGNED', :null => true
		add_column :ip_addresses, :ip_v6_1, 'BIGINT UNSIGNED', :null => true
		add_column :ip_addresses, :ip_v6_2, 'BIGINT UNSIGNED', :null => true
  end

  def down
		remove_column :ip_addresses, :ip_v4
		remove_column :ip_addresses, :ip_v6_1
		remove_column :ip_addresses, :ip_v6_2
  end
end
