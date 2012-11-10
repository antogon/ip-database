class FixDnsDeviceAssocMakeNullable < ActiveRecord::Migration
  def up
		remove_column :dns_device_assocs, :ip_id
		add_column :dns_device_assocs, :ip_id, :integer, :null => true
  end

  def down
		remove_column :dns_device_assocs, :ip_id
		add_column :dns_device_assocs, :ip_id, :integer, :null => false
  end
end
