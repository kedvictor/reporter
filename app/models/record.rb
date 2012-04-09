class Record < ActiveRecord::Base

  belongs_to :project
  belongs_to :user
  belongs_to :activity 
  
  validates :user_id, :project_id, :activity_id, 
            :date, :time, :presence => true 
  
  validates_format_of :time_before_type_cast, :with => /^[\d]{1,2}:[\d]{1,2}$/  
  
  before_save :time_to_integer 
  
  def self.for_user_and_date(user,date)  
    where( :user_id => user.id, 
      :date => (date.beginning_of_month..date.end_of_month))  
  end
  
  private  
 
    def time_to_integer
      h,m = self.time_before_type_cast.split(':')
      hours, minutes = h.to_i, m.to_i      
      if (hours > 23) or (minutes > 59)
        errors.add(:time, 'hours must be least of 24 and minutes least of 60')
        false
      else
        write_attribute(:time, (hours * 60) + minutes) 
      end   
    end 
    
end

# == Schema Information
#
# Table name: records
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  project_id  :integer
#  activity_id :integer
#  date        :date
#  time        :time
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

