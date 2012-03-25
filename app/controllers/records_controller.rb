class RecordsController < ApplicationController
  
  before_filter :authenticate
  
  def index
    @date = params[:date] ? Date.strptime(params[:date], "%Y-%m-%d") : Date.today 
    @records = Record.where( :user_id => current_user.id, 
      :date => (@date.beginning_of_month..@date.end_of_month))   
    params[:view] ? @view = 'consolidated' : nil         
  end

  def new
    @record = Record.new :date => params[:date]
  end
  
  def create
    @record = Record.new params[:record]
    @record.user = current_user   
    if @record.save
      #flash[:notice] = 'Record successfully created'
      redirect_to records_path(:date => @record.date)
    else      
      render :new
    end
  end
  
  #def edit
    #@record = Record.find params[:id]
  #end
  
  #def update
    #@record = Record.find params[:id]
    #if @record.update_attributes params[:record]
      ##flash[:notice] = 'Record successfully changed'
      #redirect_to records_path
    #else
      #render :edit
    #end
  #end
  
  #def destroy
    #@record = Record.find params[:id]
    #@record.destroy
    #redirect_to records_path
  #end 
  
end
