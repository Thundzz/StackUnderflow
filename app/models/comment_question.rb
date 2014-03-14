# coding: utf-8 

class CommentQuestion < Comment
	attr_accessible :question_id, :question
	belongs_to :question

	validates :question, presence: true

	def store_id (id)
		super
		self.question_id = id;	
	end	
	def parent
		self.question
	end
end