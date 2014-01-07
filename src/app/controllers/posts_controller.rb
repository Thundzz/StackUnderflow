class PostsController < ApplicationController


	def index
		@posts = Post.all()

	end

	def show
		
	end

	def method_name
		
	end

	def edit

		@post = Post.find( params[:id] )

	end


	def new
		@post = Post.new()

	end

	def update
		@newpost = params[:post]
		@oldpost = Post.find( params[:id] )
		@oldpost.content = @newpost[:content]
		@oldpost.title = @newpost[:title]
		@oldpost.editionNo = @oldpost.editionNo + 1
		@oldpost.save()
		redirect_to posts_path 
		
	end

	def create
		@post = Post.new(params[:post])
		@post.editionNo = 0
		if @post.save
			redirect_to posts_path, :notice => "Votre post a bien été ajouté"
		else
			render "new"
		end
	end

	def destroy
		@post = Post.find( params[:id])
		@post.destroy
		redirect_to posts_path 
	end

end
