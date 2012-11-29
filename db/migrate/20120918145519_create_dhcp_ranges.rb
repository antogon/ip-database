class CreateDhcpRanges < ActiveRecord::Migration
  def change
    create_table :dhcp_ranges do |t|
			t.column :start_ip, :string, :null => false
			t.column :end_ip, :string, :null => false
      t.timestamps
    end
  end
end
