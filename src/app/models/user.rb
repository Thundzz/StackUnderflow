# -*- coding: utf-8 -*-

class User < ActiveRecord::Base
  #expression reguliere email
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


  attr_accessor :password
  attr_accessible :email, :lastname, :name, :points, :right, :study, :password, :password_confirmation
  
  validates :lastname, :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => true
  validates :name, :presence => true, :length => { :maximum => 50 }
  # validates_inclusion_of :study, :in => [1,4]
  validates :study, :presence => true
  validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }

  before_save :encrypt_password, :default_values
  
  def default_values
    self.right ||= 2; # a modifier avec systeme de points
  end


  def has_password?(password_soumis)
    # Compare encrypted_password avec la version cryptée de
    # password_soumis.
    encrypted_password == encrypt(password_soumis)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    return nil  if user.nil?
    return user if user.salt == cookie_salt
  end




  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end


  

end
