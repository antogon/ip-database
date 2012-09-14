class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
			t.column :network_no, :integer, :null => false
			t.column :netmask, :integer, :null => false
			t.column :name, :string, :null => false
			t.column :creator_id, :string, :null => false
			t.column :updater_id, :string
			t.column :router_name, :string
			t.column :is_vrf, :boolean, :null => false, :default => false
			t.column :is_hsrp, :boolean, :null => false, :default => false
			t.column :desc, :text
			t.column :vlan_no, :integer
			t.column :network_parent, :integer

      t.timestamps
    end
  end
end
