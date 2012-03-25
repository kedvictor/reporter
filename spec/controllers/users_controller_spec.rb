require 'spec_helper'

describe UsersController do

  render_views

  describe "GET new" do
  
    before :each do
      
    end
    
    context "for newcomers" do
    
      before :each do
        test_sign_in_as_newcomer
      end
      
      it "returns http success" do       
        get :new
        response.should be_success
      end
      
      it "contains <form> tag" do
        get :new
        response.should have_selector :form     
      end
      
    end
    
    context "for registered users" do 
    
      before :each do
        test_sign_in_as_user
      end
      
      it "redirects to login page" do        
        get :new
        response.should redirect_to login_path
      end
      
      it "shows correct flash message" do        
        get :new
        flash[:notice].should ~/Only newcomer have access/
      end      
    end
    
    context "for not logged in" do
    
      before :each do
        test_sign_out
      end
      
      it "redirects to login page" do
        get :new
        response.should redirect_to login_path
      end
      
      it "shows correct flash message" do
        get :new
        flash[:notice].should ~/Only newcomer have access/
      end    
    end  
  end

  describe "POST create" do
  
    before :each do
      @user_params = {
        :login => 'johnsilver',
        :name => 'John Silver',
        :email => 'john@example.com',
        :position => 'programmer',
        :password => 'johnsilver',
        :password_confirmation => 'johnsilver'}
    end
    
    context "for newcomers" do
    
      before :each do
        test_sign_in_as_newcomer
      end
      
      context "when success" do
     
        it "creates new user" do
          count = User.count
          post :create, :user => @user_params
          User.count.should == count + 1
        end
        
        it "redirects to records page" do          
          post :create, :user => @user_params
          response.should redirect_to login_path
        end
      
      end
      
      context "when failure" do
      
        it "not creates new user" do
          count = User.count
          post :create, :user => @user_params.merge(:login => '')
          User.count.should == count
        end
        
        it "redirects to 'new' page" do          
          post :create, :user => @user_params.merge(:login => '')
          response.should render_template('users/new')
        end
        
        it "contains error message" do          
          post :create, :user => @user_params.merge(:login => '')
          response.should have_selector :div, :content => "Form is invalid"
        end            
      end       
    end
    
    context "for registered users" do 
    
      before :each do
        test_sign_in_as_user
      end
      
      it "redirects to login page" do        
        post :create, :user => @user_params
        response.should redirect_to login_path
      end
      
      it "shows correct flash message" do        
        post :create, :user => @user_params
        flash[:notice].should ~/Only newcomer have access/
      end      
    end
    
    context "for not logged in" do
    
      before :each do
        test_sign_out
      end
      
      it "redirects to login page" do
        post :create, :user => @user_params
        response.should redirect_to login_path
      end
      
      it "shows correct flash message" do
        post :create, :user => @user_params
        flash[:notice].should ~/Only newcomer have access/
      end    
    end  
  end
 
end
