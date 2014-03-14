# coding: utf-8 

class Post < ActiveRecord::Base
  attr_accessible :content, :title, :editionNo, :user
  belongs_to :user

  validates :user, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true

  def print_content
  	"#{self.content}"
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['LOWER(title) LIKE LOWER(?)', "%#{search}%"])
    else
      find(:all)
    end
  end
  
end
