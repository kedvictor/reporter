class Record < ActiveRecord::Base

  belongs_to :project
  belongs_to :user
  belongs_to :activity 
  
  validates :user_id, :project_id, :activity_id, 
            :date, :time, :presence => true 

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

