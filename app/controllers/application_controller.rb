class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user  
  helper_method :authenticate 
    
  private 
   
    def current_user  
      @current_user ||= User.find(session[:user_id]) if session[:user_id]  
    end 
    
    def authenticate
      unless current_user && (!current_user.newcomer?)
        redirect_to login_path, :notice => "Access deny. You must log in
          to perform this operation"
      end
    end
       
end
