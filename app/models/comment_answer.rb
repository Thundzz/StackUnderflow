# coding: utf-8 

class CommentAnswer < Comment
	attr_accessible :answer_id, :answer
	belongs_to :answer

	validates :answer, presence: true

	def store_id (id)
		super
  		self.answer_id = id;	
	end	
	def parent
		self.answer.question
	end

end