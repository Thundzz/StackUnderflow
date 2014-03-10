class CommentQuestion < Comment
	attr_accessible :question_id
	belongs_to :question

	def store_id (id)
		super
		self.question_id = id;	
	end	
	def parent
		self.question
	end
end