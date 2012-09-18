class CreateDnsDeviceAssocs < ActiveRecord::Migration
  def change
    create_table :dns_device_assocs do |t|
			t.column :name, :string, :null => false
			t.column :ip_id, :integer, :null => false
      t.timestamps
    end
  end
end
