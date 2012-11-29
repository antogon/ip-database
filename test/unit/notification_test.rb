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

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
