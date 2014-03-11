class Array
  def stable_sort
    n = 0
    c = lambda { |x| n+= 1; [x, n]}
    if block_given?
      sort { |a, b|
        yield(c.call(a), c.call(b))
      }
    else
      sort_by &c
    end
  end
end

class FalseClass; def to_i; 0 end end
class TrueClass; def to_i; 1 end end

class Question < ActiveRecord::Base
  
  acts_as_voteable
  attr_accessible :content, :score, :title,:tag_tokens, :user, :views
  has_many :answers
  has_many :comments
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

  def get_sorted_answers
    self.answers.stable_sort{|a, b| -1*( a[0].score <=> b[0].score)}.stable_sort{|a, b| b[0].validated.to_i <=> a[0].validated.to_i}
  end
end
