require 'spec_helper'

describe SessionsController do

  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    
    it "contains <form> tag" do
      get :new
      response.should have_selector :form    
    end
    
    it "contains 'login' field" do
      get :new
      response.should have_selector :input, :name => 'login'   
    end
    
    it "contains 'login' field with predefined value 'newcomer'" do
      get :new
      response.should have_selector :input, :name => 'login', :value => 'newcomer'   
    end
    
    it "contains 'password' field" do
      get :new
      response.should have_selector :input, :name => 'password'   
    end
    
  end

  describe "GET 'create'" do
  
    before :each do
      User.create(
        :login => 'johnsilver',
        :name => 'John Silver',
        :email => 'john@example.com',
        :position => 'programmer',
        :password => 'johnsilver',
        :password_confirmation => 'johnsilver'
      )       
      @newcomer_params = {:login => 'newcomer', :password => 'neofit'}
      @user_params = {:login => 'johnsilver', :password => 'johnsilver'}
    end
  
    context "when success" do     
      
      context "given newcomer credentials" do
      
        it "logs in as newcomer" do
          post :create, @newcomer_params
          controller.current_user.should be_newcomer
        end
        
        it "redirects to root" do
          post :create, @newcomer_params
          response.should redirect_to root_path
        end
        
        it "has a right flash message" do
          post :create, @newcomer_params
          flash[:notice].should == 'You may register now.'
        end
      end
      
      context "given user credentials" do
      
        it "logs in as user" do
          post :create, @user_params
          controller.current_user.should_not be_newcomer
        end
        
        it "redirects to main page" do
          post :create, @user_params
          response.should redirect_to records_path
        end       
      end    
    end
    
    context "when failure" do
    
      it 'redirects to loin page' do
        post :create, @user_params.merge(:login => '')
        response.should render_template 'sessions/new'
      end
      
      it 'contains error message' do
        post :create, @user_params.merge(:login => '')
        flash[:alert] == "Invalid email or password" 
      end    
    end        
  end
end
