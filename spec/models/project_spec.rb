require 'spec_helper'

describe Project do

  it "stores valid instance to database" do
    expect{Project.create(
      :title => 'Project')}.to change{Project.count}.by 1
  end
  
  it "needs presence of 'title'" do
    expect{Project.create(:title => '')}.to_not change{Project.count}
  end
  
  it "needs unique project title" do
    Project.create(:title => 'Project')
    Project.new(:title => 'Project').should_not be_valid
  end
  
  it "should have many records" do
    g = Project.reflect_on_association(:records)
    g.macro.should == :has_many
  end
  
end

# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

