# == Schema Information
#
# Table name: device_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Place for a user to add the Device Type names, times when they were created and updated
class DeviceType < ActiveRecord::Base
  # attr_accessible :name, :created_at, :updated_at
end
