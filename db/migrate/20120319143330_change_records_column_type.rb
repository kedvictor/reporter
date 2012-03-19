class ChangeRecordsColumnType < ActiveRecord::Migration
  
  def up
    change_table :records do |t|
      t.change :time, :integer
    end    
  end

  def down
    change_table :records do |t|
      t.change :time, :time
    end    
  end
end
