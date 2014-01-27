class User < ActiveRecord::Base
  attr_accessible :email, :lastname, :name, :points, :right, :study

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  #constantes enum right
  OWNER = 1
  ADMIN = 2
  USER = 3
  #constantes enum filiere
  INFO = 1
  MATMECA = 2
  ELEC = 3
  TELECOM = 4

  validates :lastname, :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => true
  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :right, :presence => true, :numericality => { :greater_than => 0, :less_than => USER }
  validates :study, :presence => true, :numericality => { :greater_than => 0, :less_than => TELECOM }

end
