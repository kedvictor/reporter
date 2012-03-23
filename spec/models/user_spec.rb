require 'spec_helper'

describe User do
  
  before :each do
    @valid_params = {
      :login => 'johnsilver',
      :name => 'John Silver',
      :email => 'john@example.com',
      :position => 'programmer',
      :password => 'johnsilver',
      :password_confirmation => 'johnsilver'
      }
  end
  
  it "creates valid instance given valid parameters" do
    User.new(@valid_params).should be_valid
  end
  
  it "stores instance to database" do
    expect{User.create(@valid_params)}.to change{User.count}.by(1)
  end
  
  it "should have many records" do
    g = User.reflect_on_association(:records)
    g.macro.should == :has_many
  end
  
  context "rejects instance when" do
  
    it "given blank 'login' field" do
      User.new(@valid_params.merge(:login => '')).should_not be_valid
    end
    
    it "given blank 'name' field" do
      User.new(@valid_params.merge(:name => '')).should_not be_valid
    end
    
    it "given blank 'email' field" do
      User.new(@valid_params.merge(:email => '')).should_not be_valid
    end
    
    it "given blank 'password' field" do
      User.new(@valid_params.merge(:password => '')).should_not be_valid
    end
    
    it "no password confirmation" do
      User.new(@valid_params.merge(
        :password_confirmation => '')).should_not be_valid
    end
    
    it "given short password" do
      User.new(@valid_params.merge(
        :password => 'a'*5, 
        :password_confirmation => 'a'*5)).should_not be_valid
    end
    
    it "given long password" do
      User.new(@valid_params.merge(
        :password => 'a'*26, 
        :password_confirmation => 'a'*26)).should_not be_valid
    end
    
    it "given invalid email format" do
      User.new(@valid_params.merge(
        :email => 'john.example.com')).should_not be_valid
    end
  end
  
  
end

# == Schema Information
#
# Table name: users
#
#  id            :integer         not null, primary key
#  login         :string(255)
#  name          :string(255)
#  email         :string(255)
#  position      :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

