class PostsController < ApplicationController


	def index
		@posts = Post.all()

	end

	def show
		@post= Post.find(params[:id])
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
		if @oldpost.save()
			redirect_to posts_path, :notice => "Votre post a été édité avec succès"
		else
			redirect_to posts_path, :notice => "Votre post n'a pas pu être édité"
		end  
		
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
		if @post.destroy
			redirect_to posts_path, :notice => "Votre post a bien été supprimé"
		else
			redirect_to posts_path, :notice => "Votre post n'a pas pu être supprimé"
		end 
	end

end
