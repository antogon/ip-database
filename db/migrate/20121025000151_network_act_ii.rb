class NetworkActIi < ActiveRecord::Migration
  def up
		remove_column :networks, :network_no
		remove_column :networks, :netmask
		add_column :networks, :network_no, :string, :null => false, :limit => 255
		add_column :networks, :netmask, :string, :null => false, :limit => 255
  end

  def down
		remove_column :networks, :network_no
		remove_column :networks, :netmask
		add_column :networks, :network_no, :integer, :null => false
		add_column :networks, :netmask, :integer, :null => false
  end
end
