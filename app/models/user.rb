class User < ActiveRecord::Base
  
  has_many :records
  
  attr_accessor :password
  
  before_save :encrypt_password  
  
  attr_accessible :login, :name, :email, :position, 
    :password, :password_confirmation

  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :login, :presence => true,
                   :length => {:maximum => 20},
                   :uniqueness => true
                   
  validates :name, :presence => true,
                   :length => {:maximum => 50}                   

  validates :email, :presence => true,
                    :uniqueness => {:case_sensitive => false},
                    :format => {:with => valid_email_regex}

  validates :password, :presence => true,
                       :confirmation => true,
                       :on => :create,
                       :length => { :within => 6..25 }   
 
  def encrypt_password  
    if password.present?  
      self.password_salt = BCrypt::Engine.generate_salt  
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)  
    end  
  end 
  
  def self.authenticate(login, password)  
    user = find_by_login(login)  
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, 
      user.password_salt)  
      user  
    else  
      nil  
    end  
  end 
  
  def newcomer?
    self.login == NEWCOMER
  end  
  
end

# == Schema Information
#
# Table name: users
#
#  id            :integer         not null, primary key
#  login         :string(255)
#  name          :string(255)
#  email         :string(255)
#  position      :string(255)
#  password_hash :string(255)
#  password_salt :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

