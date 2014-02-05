# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
before_filter CASClient::Frameworks::Rails::Filter,:except => [ :new, :create,:destroy ]
  def index
    # redirect_to root_path # a modifier, juste pour avoir affichage
  end
   def new
# 2c56c193b9569dd881d6b9109b24aaaf931b7490
    @titre = "S'identifier"
  end

  def create
    user = User.authenticate(params[:session][:email],
                           params[:session][:password])
    if user.nil?
      flash.now[:error] = "Combinaison Email/Mot de passe invalide."
      @titre = "S'identifier"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
  
  def cas
    
  end

end
