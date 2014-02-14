class Question < ActiveRecord::Base
  
acts_as_voteable
attr_accessible :content, :score, :title,:tag_tokens
  has_many :answers
  belongs_to :user
 has_and_belongs_to_many :tags

 attr_reader :tag_tokens
def tag_tokens=(ids)
    self.tag_ids = ids.split(",")
  end
def self.search(search)
  if search
    find(:all, :conditions => ['LOWER(title) LIKE LOWER(?)', "%#{search}%"])
  else
    find(:all)
  end
end
end
