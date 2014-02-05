class Tag < ActiveRecord::Base
  attr_accessible :mot_clef
  has_and_belongs_to_many :questions
  
end
