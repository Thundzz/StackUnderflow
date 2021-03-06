# coding: utf-8

class User < ActiveRecord::Base
  acts_as_voter
  
  has_karma :questions, :as => :user, :weight => [ 1, 1]
  has_karma :answers, :as => :user, :weight => [ 1, 1]
  #expression reguliere email
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #constantes enum right
  OWNER = 1
  ADMIN = 2
  USER = 3
  #BANISHED = 4
  #constantes enum filiere
  INFO = 1
  MATMECA = 2
  ELEC = 3
  TELECOM = 4
  
  
  attr_accessor :password
  attr_accessible :login, :email, :lastname, :name, :points, :right, :study, :password, :password_confirmation, :badges

  has_many :answers
  has_many :posts
  has_many :questions
  has_many :comments
  has_and_belongs_to_many :badges
  
  
  validates :login, :presence => true, :length => { :maximum => 50 }, :uniqueness => true
  validates :lastname, :length => { :maximum => 50 }
  validates :email, :format => { :with => email_regex }, :uniqueness => true, :if => :email?
  validates :name, :length => { :maximum => 50 }
  # validates_inclusion_of :study, :in => [1,4]
  #validates :study
  validates :password, :confirmation => true, :length => { :within => 6..40 }, :allow_nil => true
  # validate :login_change, :on => :update

  before_save :encrypt_password, :default_values
  
  def default_values
    self.right ||= 3; # a modifier avec systeme de points
    self.points ||=0;
  end

  def is_admin?
    self.right == ADMIN
  end

  def has_password?(password_soumis)
    # Compare encrypted_password avec la version cryptée de
    # password_soumis.
    encrypted_password == encrypt(password_soumis)
  end
  
  def self.authenticate(login, submitted_password)
    user = find_by_login(login)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    return nil if user.nil?
    return user if user.salt == cookie_salt
  end
  
  def self.search(search)
    if search
      find(:all, :conditions => ['LOWER(login) LIKE LOWER(?)', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  def give_badge (badge)
    if (badge && !self.badges.exists?(badge))
      self.badges << badge

    end
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
  
    
    # def login_change
    #   errors.add(:login, "cannot be changed") if self.login_changed? 
    # end


end
