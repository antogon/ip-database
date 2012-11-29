class UpdateDnsDeviceAssocs < ActiveRecord::Migration
  def up
		remove_column :dns_device_assocs, :ip_id
  end

  def down
		remove_column :dns_device_assocs, :ip_id
  end
end
