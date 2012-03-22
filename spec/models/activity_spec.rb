require 'spec_helper'

describe Activity do
  
  it "contains 'self development' item" do
    activities = Factory :activity
    Activity.find_by_activity("Self development").should_not be_nil
  end  
end

# == Schema Information
#
# Table name: activities
#
#  id         :integer         not null, primary key
#  activity   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

