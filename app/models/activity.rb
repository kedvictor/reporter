class Activity < ActiveRecord::Base

  has_many :records

  validates :activity, :presence => true, :uniqueness => true

end

# == Schema Information
#
# Table name: activities
#
#  id         :integer         not null, primary key
#  activity   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

