class NotificationInheritcanceColumn < ActiveRecord::Migration
  def up
		remove_column :notifications, :type
		add_column :notifications, :note_type, 'ENUM("note","info","fail","success","warn")', :default => 'note', :null => false
  end

  def down
		remove_column :notifications, :note_type
			t.column :type, 'ENUM("note","info","fail","success","warn")', :default => "note", :null => false
  end
end
