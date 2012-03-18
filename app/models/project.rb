class Project < ActiveRecord::Base

  has_many :records
  
  validates :title, :presence => true
  validates :title, :uniqueness => true

end

# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

