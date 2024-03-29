class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])  
    
    if user && user.newcomer? 
      session[:user_id] = user.id     
      return redirect_to root_path, :notice => 'You may register now.'
    end
    
    if user  
      session[:user_id] = user.id       
      redirect_to records_path
      # :notice => "Logged in."
    else  
      flash.now.alert = "Invalid email or password"  
      render "new"  
    end  
  end
  
  # for console only
  def destroy
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Logged out!"  
  end
end
