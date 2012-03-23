require 'spec_helper'

describe Activity do
  
  it "contains 'Self development' item" do
    Activity.find_by_activity("Self development").should be
  end 
  
  it "contains 'Working time' item" do
    Activity.find_by_activity("Self development").should be
  end 
  
  it "contains 'Extra time' item" do
    Activity.find_by_activity("Self development").should be
  end 
  
  it "contains 'Team time' item" do
    Activity.find_by_activity("Self development").should be
  end 
  
  it "rejects instance given blank 'activity' attribute" do
    Activity.new(:activity => '').should_not be_valid
  end
  
  it "should have many records" do
    g = Activity.reflect_on_association(:records)
    g.macro.should == :has_many
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

