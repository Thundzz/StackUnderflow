class Question < ActiveRecord::Base
  attr_accessible :content, :score, :title
  has_many :answers
end
