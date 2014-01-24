class QuestionsController < ApplicationController
	def index
		@questions = Question.all()

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
			redirect_to questions_path, :notice => "Votre question a été éditée avec succès"
		else
			redirect_to questions_path, :notice => "Votre question n'a pas pu être éditée"
		end  
		
	end

	def create
		question = Question.new(params[:question])
		if question.save
			redirect_to questions_path, :notice => "Votre question a bien été ajoutée"
		else
			render "new"
		end
	end

	def destroy
		question = Question.find( params[:id])
		if question.destroy
			redirect_to questions_path, :notice => "Votre question a bien été supprimée"
		else
			redirect_to questions_path, :notice => "Votre question n'a pas pu être supprimée"
		end 
	end
end
