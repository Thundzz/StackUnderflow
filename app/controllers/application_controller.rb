# coding: utf-8 

class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper #inclut modele session helper
  
  # Before filters
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Veuillez vous identifier."
    end
  end
end
