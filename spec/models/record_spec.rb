require 'spec_helper'

describe Record do

  before :each do
    @valid_params = {
      :user_id => 1,
      :project_id => 1,
      :activity_id => 1,
      :date => '2012-01-01',
      :time => '01:01',
      :description  => 'description'    
    }
  end

  it "creates valid instance given valid parameters" do
    Record.new(@valid_params).should be_valid
  end
  
  it "stores valid record to database" do
    expect{Record.create(@valid_params)}.to change{Record.count}.by(1) 
  end
  
  it "needs presence of user_id" do
    Record.new(@valid_params.merge(:user_id => nil)).should_not be_valid
  end
  
  it "needs presence of project_id" do
    Record.new(@valid_params.merge(:project_id => nil)).should_not be_valid
  end
  
  it "needs presence of activity_id" do
    Record.new(@valid_params.merge(:activity_id => nil)).should_not be_valid
  end
  
  it "needs presence of date" do
    Record.new(@valid_params.merge(:date => nil)).should_not be_valid     
  end
  
  it "needs presence of time" do
    Record.new(@valid_params.merge(:time => nil)).should_not be_valid
  end
  
  it "needs right format of time field ('HH:MM')" do   
    %w(01-01, 01:01, 01:001).each do |time|
      Record.new(@valid_params.merge(:time => time)).should_not be_valid
    end
  end
  
  it "rejects record given time field > 23 hours" do   
    expect{Record.create(@valid_params.merge(
      :time => '24:00'))}.to_not change{Record.count}.by(1) 
  end
  
  it "rejects record given time field > 59 minutes" do   
    expect{Record.create(@valid_params.merge(
      :time => '00:60'))}.to_not change{Record.count}.by(1) 
  end
  
  it "belongs to User" do
    g = Record.reflect_on_association(:user)
    g.macro.should == :belongs_to
  end
  
  it "belongs to Activity" do
    g = Record.reflect_on_association(:activity)
    g.macro.should == :belongs_to
  end
  
  it "belongs to Project" do
    g = Record.reflect_on_association(:project)
    g.macro.should == :belongs_to
  end
  
end


# == Schema Information
#
# Table name: records
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  project_id  :integer
#  activity_id :integer
#  date        :date
#  time        :time
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

