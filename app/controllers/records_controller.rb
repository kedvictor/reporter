class RecordsController < ApplicationController
  
  def index
    @records = Record.where( :user_id => current_user.id )
  end

  def new
    @record = Record.new
  end
  
  def create
    @record = Record.new params[:record]
    @record.user = current_user
    if @record.save
      flash[:notice] = 'Record successfully created'
      redirect_to records_path
    else
      render :new
    end
  end
  
  def edit
    @record = Record.find params[:id]
  end
  
  def update
    @record = Record.find params[:id]
    if @record.update_attributes params[:record]
      flash[:notice] = 'Record successfully changed'
      redirect_to records_path
    else
      render :edit
    end
  end
  
  def destroy
    @record = Record.find params[:id]
    @record.destroy
    redirect_to records_path
  end 
  
end
