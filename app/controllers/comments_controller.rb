class CommentsController < ApplicationController

  before_filter :signed_in_user, only: [:create, :new, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy]

	def new
		@comment = comment_type.new
		@comment.store_id params[:parent_id]

	end
	def create
		parent = params[comment_symbol][:parent_id]
		comment = comment_type.new(params[comment_symbol])
		comment.store_id parent
		comment.user = current_user

		if comment.save
			redirect_to question_path(comment.parent), :notice => "Votre commentaire a bien ete ajoute"
		else
			render "new"
		end

	end

	private
	def comment_type
		params[:type].constantize
	end


	def comment_symbol
		params[:type].underscore.to_sym
	end

end
