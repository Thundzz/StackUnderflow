# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

def index
		@users = User.search(params[:search])             

		if params[:term]
			logger.info '**parametre term reçu**'
                        logger.info params[:term]
                         a=params[:term]
	@usera = User.find(:all,:conditions => ['LOWER(name) LIKE ? or LOWER(lastname) LIKE ?', "%"+a.downcase+"%","%"+a.downcase+"%"]) 
			logger.info 'debug'
			logger.info @usera
		else
			@usera = User.all 
			logger.info 'no term'
                        logger.info @usera
		end
		
		respond_to do |format|  
			format.html 
			logger.info 'json'
			logger.info @usera.to_json
			format.json { render :json => @usera.to_json }
		end		
	end

  def new
    @title = "S'inscrire"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Inscription réussie"
      redirect_to @user
    else
      @titre = "Inscription"
      render 'new'
    end
  end


end
