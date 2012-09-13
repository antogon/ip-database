# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120913205056) do

  create_table "ip_addresses", :force => true do |t|
    t.string   "contact",                           :null => false
    t.string   "location",                          :null => false
    t.integer  "device_type",                       :null => false
    t.integer  "network_parent"
    t.text     "desc"
    t.boolean  "is_static_dhcp", :default => false, :null => false
    t.boolean  "has_dns_assoc",  :default => false, :null => false
    t.string   "mac_address"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "networks", :force => true do |t|
    t.integer  "network_no",                        :null => false
    t.integer  "netmask",                           :null => false
    t.string   "name",                              :null => false
    t.string   "creator_id",                        :null => false
    t.string   "updater_id"
    t.string   "router_name"
    t.boolean  "is_vrf",         :default => false, :null => false
    t.boolean  "is_hsrp",        :default => false, :null => false
    t.text     "desc"
    t.integer  "vlan_no"
    t.integer  "network_parent"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

end
