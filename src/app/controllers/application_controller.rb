class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper #inclut modele session helper
end
