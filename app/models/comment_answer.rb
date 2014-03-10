class CommentAnswer < Comment
	attr_accessible :answer_id
	belongs_to :answer

	def store_id (id)
		super
  		self.answer_id = id;	
	end	
	def parent
		self.answer.question
	end

end