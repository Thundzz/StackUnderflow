# coding: utf-8 
class PostsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :new, :edit, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update, :destroy]


	# Before filter
	def correct_user
		@post = Post.find( params[:id] )
		if @post.user != current_user
			redirect_to @post, :notice => "Vous ne pouvez modifier que vos propres posts"
		end
	end


	def index
		@posts = Post.search(params[:search])

		if params[:term]
			@posta = Post.find(:all,:conditions => ['LOWER(title) LIKE LOWER(?)', "%#{params[:term]}%"]) 
			logger.info 'debug'
			logger.info @posta
		else
			@posta = Post.all 
			logger.info 'no term'
		end
		
		respond_to do |format|  
			format.html 
			logger.info 'json'
			logger.info @posta.to_json
			format.json { render :json => @posta.to_json }
		end		
	end


	def show
		@post= Post.find(params[:id])
	end

	def edit
		@post = Post.find( params[:id] )
	end


	def new
		@post = Post.new()
	end

	def update
		@oldpost = Post.find( params[:id] )
		@newpost = params[:post]
		
		@oldpost.content = @newpost[:content]
		@oldpost.title = @newpost[:title]
		@oldpost.editionNo = @oldpost.editionNo + 1
		if @oldpost.save()
			redirect_to posts_path, :notice => "Votre post a ete edite avec succes"
		else
			redirect_to posts_path, :notice => "Votre post n'a pas pu etre edite"
		end
	end

	def create
		@post = current_user.posts.build(params[:post])

		@post.editionNo = 0
		#@post.user = current_user
		if @post.save
			redirect_to posts_path, :notice => "Votre post a bien ete ajoute"
		else
			render "new"
		end
	end

	def destroy
		@post = Post.find( params[:id])
		if @post.destroy
			redirect_to posts_path, :notice => "Votre post a bien ete supprime"
		else
			redirect_to posts_path, :notice => "Votre post n'a pas pu etre supprime"
		end
	end

end
