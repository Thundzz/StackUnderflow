# coding: utf-8 

class UsersController < ApplicationController
  include UsersHelper #inclut modele session helper

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
    if @user.update_attributes(params[:user])
      flash[:success] = "Profil modifié avec succès."
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :lastname, :study, :email, :password, :password_confirmation)
  end
  

end
