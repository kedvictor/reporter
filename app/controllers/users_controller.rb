class UsersController < ApplicationController

  before_filter :for_newcomer_only

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])  
    if @user.save  
      redirect_to login_path, 
        :notice => "You have new login and password now. 
          Please, use this credentials for log in rather than 'newcomer'"  
    else  
      render "new"  
    end   
  end
  
  private
  
    def for_newcomer_only
      unless current_user && current_user.newcomer?
      redirect_to login_path, 
        :notice => "Only newcomer have access to this operation"
      end  
    end
    
end
