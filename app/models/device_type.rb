# == Schema Information
#
# Table name: device_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DeviceType < ActiveRecord::Base
  # attr_accessible :title, :body
end
