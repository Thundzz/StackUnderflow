# coding: utf-8 

require 'will_paginate/array'
require 'nokogiri'

class QuestionsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :new, :edit, :update, :destroy]
  before_filter :correct_or_admin_user, only: [:edit, :update, :destroy]
  
  
  # Before filter
  def correct_or_admin_user
    @question = Question.find( params[:id] )
    if (@question.user != current_user && !(signed_in? && current_user.is_admin?))
      redirect_to @question, :notice => "Vous ne pouvez modifier que vos propres questions"
    end
  end
  
  
  def index
    # criteria = (params[:search] !=  nil) ? (lambda{|q| q.score}) : (lambda{|q| q.updated_at}) 
    # @questions = Question.search(params[:search]).sort_by{|q| criteria.call(q)}.reverse.paginate(:page => params[:page], :per_page => 8)
   
    if params[:search]
      # Si on fait une recherche dans les questions, on les trie par score
      @questions = Question.sort_by_score.search(params[:search]).paginate(:page => params[:page], :per_page => 8)
    else
      # Sinon, on les trie selon la dernière date de mise à jour de la question
      @questions = Question.sort_by_updated_at.paginate(:page => params[:page], :per_page => 8)
    end

    #je suis incapable de trouver une syntaxe pour directement trier dans l'ordre décroissant.

    
     #@questions = Question.search(params[:search]).sort_by{|q| q.created_at}.reverse.paginate(:page => params[:page], :per_page => 8) 

     if params[:term]
      @questiona = Question.find(:all,:conditions => ['LOWER(title) LIKE LOWER(?)', "%#{params[:term]}%"]) 
      logger.info 'debug Question controller'
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
    if(current_user != nil && current_user.id != @question.user.id)
      @question.views = @question.views + 1
    end
    Badge.update_on_question_view(@question)
    @question.save
    positive_vote_count = @question.votes_for
    negative_vote_count = @question.votes_against
    
    @vote_count_show =positive_vote_count-negative_vote_count
    @answers = @question.get_sorted_answers
  end
  
  
  def edit

    @question = Question.find( params[:id] )
    @tag=Tag.new()
  end
  
  
  def new
    @question = Question.new()
    @tag=Tag.new()
    
  end
  
  def update
    oldquestion = Question.find(params[:id])
    if oldquestion.update_attributes(params[:question])
      redirect_to questions_path, :notice => "Votre question a été editée avec succès"
    else
      redirect_to questions_path, :notice => "Votre question n'a pas pu être éditée"
    end  
    
  end
  
  def create
    question = current_user.questions.build(params[:question])
    question.views = 0
    question.score = 0
    if question.save
      Badge.update_on_question(question)
      redirect_to questions_path, :notice => "Votre question a bien ete ajoutee"
    else
      render "new"
    end
  end
  
  def destroy
    question = Question.find( params[:id])
    if question.destroy
      redirect_to questions_path, :notice => "Votre question a bien eté supprimée"
    else
      redirect_to questions_path, :notice => "Votre question n'a pas pu être supprimée"
    end 
  end
  
  
  def vote_for
    @quest_vote_for = Question.find(params[:id])
    @question_id=@quest_vote_for

    if(current_user.id != @quest_vote_for.user.id)
      @test=0
      if current_user.voted_against?(@quest_vote_for)
        current_user.unvote_for(@quest_vote_for)
      else 
        current_user.vote_exclusively_for(@quest_vote_for)
      end
    else
      @test=1
    end
    positive_vote_count = @quest_vote_for.votes_for
    negative_vote_count = @quest_vote_for.votes_against
    @total_vote =positive_vote_count-negative_vote_count

    @quest_vote_for.score = @total_vote
    @quest_vote_for.save

    respond_to do |format|
      format.js
      format.html
    end
    Badge.update_on_question_vote_up(@quest_vote_for)
  end
  
  def vote_against
    @quest_vote_against = Question.find(params[:id])
    @question_id=params[:id]
    if(current_user.id != @quest_vote_against.user.id)
      @test=0
      if current_user.voted_for?(@quest_vote_against)
        current_user.unvote_for(@quest_vote_against)
      else 
        current_user.vote_exclusively_against(@quest_vote_against)
      end
    else
      @test=1
    end
    positive_vote_count = @quest_vote_against.votes_for
    negative_vote_count = @quest_vote_against.votes_against
    @total_vote =positive_vote_count-negative_vote_count

    @quest_vote_against.score = @total_vote
    @quest_vote_against.save

    respond_to do |format|
      format.js
      format.html
    end
  end
  
  
  def handle_tags
    @question = Question.find(params[:id])
  end
  
  
end
