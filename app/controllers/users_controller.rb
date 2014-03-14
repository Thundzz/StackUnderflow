# coding: utf-8 

require 'will_paginate/array'

class UsersController < ApplicationController
  include UsersHelper #inclut modele session helper
  #before_filter :correct_user, only: [:index]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  
  # Before filter
  def correct_user
    @user = User.find( params[:id] )
    if @user != current_user
      redirect_to @user, :notice => "Vous ne pouvez modifier que votre propre profil"
    end
  end
  

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def edit_avatar
    @test=0
    @user = User.find(params[:id])
    if(current_user.id != @user.id)
      @test=2
    elsif @user.email.blank?
      @test=1
    end
    
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def index
    @users = User.search(params[:search]).paginate(:page => params[:page], :per_page => 24)     
    
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
    if signed_in?
      redirect_to current_user
    end
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

  def edit
    @title = "Editer votre profil"
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil modifié avec succès."
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

  def user_params
    #params.require(:user).permit(:name, :lastname, :study, :email, :password, :password_confirmation)
    params[:user].except(:login)
  end
  

end
