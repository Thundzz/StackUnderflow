class AnswersController < ApplicationController
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
