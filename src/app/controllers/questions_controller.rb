# -*- coding: utf-8 -*-
class QuestionsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :new, :edit, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update, :destroy]


	# Before filter
	def correct_user
		@question = Question.find( params[:id] )
		if @question.user != current_user
			redirect_to @question, :notice => "Vous ne pouvez modifier que vos propres questions"
		end
	end

	
	def index
		@questions = Question.search(params[:search])             

		if params[:term]
        	@questiona = Question.find(:all,:conditions => ['LOWER(title) LIKE LOWER(?)', "%#{params[:term]}%"]) 
        	logger.info 'debug Qustion controller'
        	logger.info @questiona
        else
        	@questiona = Question.all 
        	logger.info 'no term Question'
        end
 
       	respond_to do |format|  
       		format.html 
       		logger.info 'json'
       		logger.info @questiona.to_json
       		format.json { render :json => @questiona.to_json }
       	end		
    end

	def show
		@question= Question.find(params[:id])

		@answers = @question.answers
	end
	
	def edit

		@question = Question.find( params[:id] )
	end


	def new
		@question = Question.new()

	end

	def update
		oldquestion = Question.find(params[:id])
		if oldquestion.update_attributes(params[:question])
			redirect_to questions_path, :notice => "Votre question a ete editee avec succes"
		else
			redirect_to questions_path, :notice => "Votre question n'a pas pu etre editee"
		end  
		
	end

	def create
		question = current_user.questions.build(params[:question])
		if question.save
			redirect_to questions_path, :notice => "Votre question a bien ete ajoutee"
		else
			render "new"
		end
	end

	def destroy
		question = Question.find( params[:id])
		if question.destroy
			redirect_to questions_path, :notice => "Votre question a bien eté supprimee"
		else
			redirect_to questions_path, :notice => "Votre question n'a pas pu etre supprimee"
		end 
	end
end
