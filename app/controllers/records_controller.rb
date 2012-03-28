class RecordsController < ApplicationController
  
  before_filter :authenticate
  
  def index
    @date = set_date(params[:date])
    # move to model
    @records = Record.where( :user_id => current_user.id, 
      :date => (@date.beginning_of_month..@date.end_of_month))   
    params[:view] ? @view = 'consolidated' : nil         
  end

  def new
    @record = Record.new :date => params[:date]
  end
  
  def create
    #current_user.record.build params[:record]
    @record = Record.new params[:record]
    @record.user = current_user   
    if @record.save
      #flash[:notice] = 'Record successfully created'
      redirect_to records_path(:date => @record.date)
    else      
      render :new
    end
  end
  
  private
    
    def set_date( date )      
      return date = Date.parse("#{date[:year]}-#{date[:month]}-#{date[:day]}") if date.is_a? Hash     
      date ? Date.strptime(date, "%Y-%m-%d") : Date.today 
    end  
  
end
