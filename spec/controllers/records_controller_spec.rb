require 'spec_helper'

describe RecordsController do

  render_views
  
  describe "GET index" do
  
    context "for non-authenticated user" do
    
      before :each do
        test_sign_out
      end
      
      it "redirects to login page" do
        get :index
        response.should redirect_to login_path
      end
      
      it "has right flash message" do
        get :index
        flash[:notice].should =~ /Access deny/
      end
    end
    
    context "for newcomer" do
      
      before :each do
        test_sign_in_as_newcomer
      end
      
      it "redirects to login page" do
        get :index
        response.should redirect_to login_path
      end
      
      it "has right flash message" do
        get :index
        flash[:notice].should =~ /Access deny/
      end
    end
    
    context "for authenticated user" do
    
      before :each do
        test_sign_in_as_user
      end
    
      it "returns http success" do       
        get :index
        response.should be_success
      end
      
      context "if date not assigned" do
        it "assigns today date" do
          get :index
          assigns(:date).should == (Date.today)
        end
      end
      
      context "if date assigned" do
        it "assigns right date" do
          get :index, :date => (Date.today - 1.day)
          assigns(:date).should == (Date.today - 1.day)
        end
      end
      
      context "if view not assigned" do
        it "assigns blank view" do
          get :index, :view => nil
          assigns(:view).should be_nil
        end
      end
      
      context "if view assigned as 'consolidated'" do
        it "assigns consolidated view" do
          get :index, :view => 'consolidated'
          assigns(:view).should be
        end
      end
      
      it "assigns current month records only" do
      end
      
      it "assigns current user records only" do
      end
      
    end
  end
  
  describe "GET new" do  
  end
  
  describe "POST create" do  
  end
 
end
