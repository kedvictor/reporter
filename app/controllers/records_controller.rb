class RecordsController < ApplicationController
  
  before_filter :authenticate
  
  def index
    @date = set_date(params[:date])   
    @records = Record.for_user_and_date(current_user,@date)  
    params[:view] ? @view = 'consolidated' : nil         
  end

  def new
    @record = Record.new :date => params[:date]
  end
  
  def create
    @record = current_user.records.build params[:record]    
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
