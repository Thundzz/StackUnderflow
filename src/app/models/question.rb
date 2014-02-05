class Question < ActiveRecord::Base
  attr_accessible :content, :score, :title
  has_many :answers
  has_and_belongs_to_many :tags
  belongs_to :user

def self.search(search)
  if search
    find(:all, :conditions => ['LOWER(title) LIKE LOWER(?)', "%#{search}%"])
  else
    find(:all)
  end
end
end
