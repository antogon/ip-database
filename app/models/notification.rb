# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  note_type  :string(7)        default("note"), not null
#
# Provides an option for user to create a new notification and registers times it was created and updated.
class Notification < ActiveRecord::Base
	attr_accessible :id, :name, :body, :note_type, :created_at, :updated_at

	scope :after, lambda{|time| where('created_at > ?',time)}
	
end
