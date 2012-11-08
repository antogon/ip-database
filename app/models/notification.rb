class Notification < ActiveRecord::Base
	attr_accessible :id, :name, :body, :note_type, :created_at, :updated_at

	scope :after, lambda{|time| where('created_at > ?',time)}
	
end
