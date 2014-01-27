# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def index 
    @users = User.all()
  end

  def new
    @title = "S'inscrire"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Inscription réussie"
      redirect_to @user
    else
      @titre = "Inscription"
      render 'new'
    end
  end


end
