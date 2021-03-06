# coding: utf-8 
class SessionsController < ApplicationController
before_filter CASClient::Frameworks::Rails::Filter,:except => [ :new, :create,:destroy ]
  def index
    unless session[:cas_user].blank?
      create_or_login_user session[:cas_user]
    end
  end

  def new
    @titre = "S'identifier"
  end

  def create
    user = User.authenticate(params[:session][:login],
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
