require 'spec_helper'

describe RecordsController do

  render_views

  # needs refactor: user stories needs to rewrite to behave_like!

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
        last_month_record = Factory :record, :date => (Date.today - 1.month),
          :user_id => controller.current_user.id
        this_month_record = Factory :record, :date => (Date.today),
          :user_id => controller.current_user.id
        get :index, :date => (Date.today - 1.month)
        assigns(:records).length.should == 1
        assigns(:records).first.should == last_month_record
      end

      it "assigns current user records only" do
        current_user_record = Factory :record,
          :user_id => controller.current_user.id
        another_user_record = Factory :record,
          :user_id => 9999
        get :index
        assigns(:records).length.should == 1
        assigns(:records).first.should == current_user_record
      end

      it "provides right total time output" do
        rec1 = Factory :record, :time => "01:01",
          :user_id => controller.current_user.id
        rec2 = Factory :record, :time => "00:49",
          :user_id => controller.current_user.id
        get :index
        response.should have_selector :div, :class => 'total',
          :content => "Total: 01:50"
      end
      
      it "contains <Today> link if current date is not today" do
		get :index, :date => Date.today - 1.day
		response.should have_selector :a, 
		  :href => records_path(:date => Date.today)
      end
      
      it "contains <Today> text if current date is today" do
		get :index, :date => Date.today
		response.should contain('Today')
      end
      
    end
  end

  describe "GET new" do

    context "for non-authenticated user" do

      before :each do
        test_sign_out
      end

      it "redirects to login page" do
        get :new, :date => Date.today
        response.should redirect_to login_path
      end

      it "has right flash message" do
        get :new, :date => Date.today
        flash[:notice].should =~ /Access deny/
      end
    end

    context "for newcomer" do

      before :each do
        test_sign_in_as_newcomer
      end

      it "redirects to login page" do
        get :new, :date => Date.today
        response.should redirect_to login_path
      end

      it "has right flash message" do
        get :new, :date => Date.today
        flash[:notice].should =~ /Access deny/
      end
    end

    context "for authenticated user" do

      before :each do
        test_sign_in_as_user
      end

      it "returns http success" do
        get :new, :date => Date.today
        response.should be_success
      end

      it "assigns new record" do
        get :new, :date => Date.today
        assigns(:record).should be_new_record
      end

      it "assigns given date" do
        get :new, :date => Date.today - 1.day
        assigns(:record).date.should == Date.today - 1.day
      end

      it "contains <form> tag" do
        get :new, :date => Date.today
        response.should have_selector :form
      end
    end
  end

  describe "POST create" do

    before :each do
      @params = {
        :user_id => 1,
        :project_id => 1,
        :activity_id => 1,
        :date => Date.today,
        :time => '01:01'
      }
    end

    context "for non-authenticated user" do

      before :each do
        test_sign_out
      end

      it "redirects to login page" do
        post :create, :record => @params
        response.should redirect_to login_path
      end

      it "has right flash message" do
        post :create, :record => @params
        flash[:notice].should =~ /Access deny/
      end
    end

    context "for newcomer" do

      before :each do
        test_sign_in_as_newcomer
      end

      it "redirects to login page" do
        post :create, :record => @params
        response.should redirect_to login_path
      end

      it "has right flash message" do
        post :create, :record => @params
        flash[:notice].should =~ /Access deny/
      end
    end

    context "for authenticated user" do

      before :each do
        test_sign_in_as_user
      end

      context "when success" do

        it "returns http success" do
          post :create, :record => @params
          response.should redirect_to(records_path(:date => Date.today))
        end

        it "redirects to view for created record date" do
          post :create, :record => @params.merge(:date => Date.today - 1.day)
          response.should redirect_to(records_path(:date => Date.today - 1.day))
        end

        it "assigns record for current user" do
          post :create, :record => @params
          assigns(:record).user.should == controller.current_user
        end

        it "stores record to database" do
          count = Record.count
          post :create, :record => @params
          Record.count.should == count + 1
        end
      end

      context "when failure" do

        it "not stores record to database" do
          count = Record.count
          post :create, :record => @params.merge(:time => '')
          Record.count.should == count
        end

        it "redirects to 'new' page" do
          post :create, :record => @params.merge(:time => '99:99')
          response.should render_template('records/new')
        end

        it "contains error message" do
          post :create, :record => @params.merge(:time => '')
          response.should have_selector :div, :content => "Form is invalid"
        end
      end
    end
  end
end

