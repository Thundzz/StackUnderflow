class PostsController < ApplicationController


	def index
		@posts = Post.all()

	end

	def edit

		@post = Post.find(1)
		@post.editionNo = @post.editionNo + 1
		postnumber = @post.editionNo
		@post.save()
	end

end
