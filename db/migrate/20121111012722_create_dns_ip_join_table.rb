class CreateDnsIpJoinTable < ActiveRecord::Migration
  def change
		create_table :dns_ip_joins do |t|
			t.column :dns_id, :integer, :null => false
			t.column :ip_id, :integer, :null => false
			t.timestamps
		end
  end
end
