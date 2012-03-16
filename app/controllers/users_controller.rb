class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])  
    if @user.save  
      redirect_to root_url, :notice => "You are successfully registered now."  
    else  
      render "new"  
    end   
  end
end
