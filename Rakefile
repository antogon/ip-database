#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

IpDatabase::Application.load_tasks

desc "Populate DB with Test Data"
task :populate_db => :environment do
	for i in 1..10
		type = DeviceType.new({:name => Faker::Name.title})
		type.save
		rnum = [true,false].sample
		net = Network.new({:name => Faker::Name.first_name + "'s AP", :creator_id => Faker::Internet.user_name, :router_name => "", :is_vrf => false, :is_hsrp => false, :network_no => (rnum) ? Faker::Internet.ip_v6_address : Faker::Internet.ip_v4_address, :netmask => (rnum) ? Faker::Internet.ip_v6_address : Faker::Internet.ip_v4_address})
		net.save
		dhcp_begin = IP.parse((rnum) ? Faker::Internet.ip_v6_address : Faker::Internet.ip_v4_address)
		dhcp = DhcpRange.new({:start_ip => dhcp_begin.to_s, :end_ip => (dhcp_begin+255).to_s, :network_parent => net.id})
		dhcp.save
		for j in 1..200
			ip = IpAddress.new({:contact => Faker::Name.first_name + " " + Faker::Name.last_name, :location => Faker::Address.latitude + " : " + Faker::Address.longitude, :network_parent => net.id, :device_type => type.id})
			if rnum
				ip.ip_v4 = Faker::Internet.ip_v4_address
			else
				ip.ip_v6 = Faker::Internet.ip_v6_address
			end
			ip.save
			dns = DnsDeviceAssoc.new({:name => Faker::Name.title, :ip_id => ip.id})
			dns.save
		end
	end
end
