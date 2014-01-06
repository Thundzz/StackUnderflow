class PostsController < ApplicationController


	def index
		@posts = Post.all()

	end

	def edit

		@post = Post.find( params[:id] )
		@post.editionNo = @post.editionNo + 1
		postnumber = @post.editionNo
		@post.save()
		redirect_to posts_path 

	end


	def new
		@post = Post.new()

	end

	def create
		@post = Post.new(params[:post])
		@post.editionNo = 0
		@post.save
		redirect_to posts_path 
		
	end

end
