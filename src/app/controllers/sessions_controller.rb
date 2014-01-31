# -*- coding: utf-8 -*-

class SessionsController < ApplicationController
before_filter CASClient::Frameworks::Rails::Filter,:except => [ :new, :create,:destroy ]
  def index
 
end
   def new
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
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
  
def cas

end

end
