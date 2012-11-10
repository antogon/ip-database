class ApplicationController < ActionController::Base
  protect_from_forgery

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

	def session_update
		if !session[:create_time]
			session[:create_time] = lambda{Time.now}.call
		end
	end
end
