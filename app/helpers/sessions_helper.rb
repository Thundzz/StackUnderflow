# -*- coding: utf-8 -*-
module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.url if request.get?
  end
  
  
  def create_or_login_user(login)
    # On teste d'abord la présence ou non du User
    user = User.find_by_login(login)
    if user.nil?
      user = User.new(login: login)
      if user.save
        sign_in user
        flash[:success] = "Connexion par le CAS réussie. Nous vous encourageons à renseigner votre profil pour optimiser votre utilisation de StackUnderflow !"
        redirect_back_or user
      else
        flash[:error] = "Connexion avortée : veuillez réessayer."
        redirect_to new_session_path
      end
    else
      sign_in user
      redirect_back_or user
    end
  end
  
  
  private
  
  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end
  
  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
  


end
