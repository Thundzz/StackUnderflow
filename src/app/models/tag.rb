class Tag < ActiveRecord::Base
  attr_accessible :mot_clef
  has_many :questions
end
