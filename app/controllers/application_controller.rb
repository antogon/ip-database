# Class which makes the representation of the IP-Database page. 
# This class provides user an option to create New Notifications in the Announcements section. 
# Class presents the statistics for the Networks, IP Addresses and DNS Devices. 
# Class also shows the Recent Changes made and updates the most recent date of the session.

class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :session_update
	# Contains information for the front page. Allows the user to create a notification if needed.
	# Also shows number of total, physical and virtual networks. Shows how many IP adresses total, assigned and free.
	# Shows number of DNS Devices.
	def index
		@notes = Notification.after lambda{1.weeks.ago}.call
		networks = Network.all
		@network_count = networks.length
		@network_physical = networks.delete_if {|net| net.is_vrf }.length
		@network_virtual = @network_count - @network_physical
		@ip_count = 0
		networks.each { |net| @ip_count += net.num_ip }
		@ip_assigned = 0
		networks.each { |net| @ip_assigned += net.num_ip_assigned }
		@ip_free = 0
		networks.each { |net| @ip_free += net.num_ip_free }
		@dns_count = DnsDeviceAssoc.count
		render :index
	end
	
	# Updates the times of the last session and recent changes 
	def session_update
		if !session[:create_time]
			session[:create_time] = lambda{Time.now}.call
		end
		if !session[:note_check]
			session[:note_check] = session[:create_time]
		end
		@note_stream = Notification.after session[:note_check]
		session[:note_check] = lambda{Time.now}.call
	end
end
