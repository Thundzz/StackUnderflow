# coding: utf-8 

class Answer < ActiveRecord::Base
  scope :stable_sort, order("validated DESC, score DESC, created_at DESC")
  
  acts_as_voteable
  attr_accessible :content, :score, :validated, :question_id, :user, :question
  belongs_to :question
  belongs_to :user
  has_many :comments

  validates :content, presence: true
  validates :question, presence: true
  validates :user, presence: true

  def validate
  	self.validated = true
  	self.save
  end

end
