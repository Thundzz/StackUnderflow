# coding: utf-8 

class AnswersController < ApplicationController
	before_filter :signed_in_user, only: [:create, :new, :edit, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update, :destroy]


	# Before filter
	def correct_user
		@answer = Answer.find( params[:id] )
		if @answer.user != current_user
			redirect_to @answer.question, :notice => "Vous ne pouvez modifier que vos propres reponses"
		end
	end


	def index
		@answers = Answer.all()
	end

	def show
		@answer= Answer.find(params[:id])
	end

	def edit
		@answer = Answer.find( params[:id] )

	end


	def new
		@answer = Answer.new()
		@question = Question.find(params[:question_id])
		@answer.question_id = (params[:question_id])
	end

	def update
		oldanswer = Answer.find(params[:id])
		if oldanswer.update_attributes(params[:answer])
			redirect_to question_path(oldanswer.question), :notice => "Votre reponse a ete editee avec succes"
		else
			redirect_to question_path(oldanswer.question), :notice => "Votre reponse n'a pas pu etre editee"
		end  
		
	end

	def create
		puts("create params hash : " )
		puts(params[:answer])
		answer = Answer.new(params[:answer])
		answer.user = current_user
		if answer.save
			redirect_to question_path(answer.question), :notice => "Votre reponse a bien ete ajoutee"
		else
			render "new"
		end
	end

	def destroy
		answer = Answer.find( params[:id])
		if answer.destroy
			redirect_to question_path(answer.question), :notice => "Votre reponse a bien ete supprimee"
		else
			redirect_to question_path(answer.question), :notice => "Votre reponse n'a pas pu etre supprimee"
		end 
	end
end
