class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
			t.column :name, :string, :null => true
			t.column :body, :text, :null => true
			t.column :type, 'ENUM("note","info","fail","success","warn")', :default => "note", :null => false
      t.timestamps
    end
  end
end
