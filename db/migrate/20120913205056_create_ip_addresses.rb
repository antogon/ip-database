class CreateIpAddresses < ActiveRecord::Migration
  def change
    create_table :ip_addresses do |t|
			t.column :contact, :string, :null => false
			t.column :location, :string, :null => false
			t.column :device_type, :integer, :null => false
			t.column :network_parent, :integer
			t.column :desc, :text
			t.column :is_static_dhcp, :boolean, :null => false, :default => false
			t.column :has_dns_assoc, :boolean, :null => false, :default => false
			t.column :mac_address, :string

      t.timestamps
    end
  end
end
