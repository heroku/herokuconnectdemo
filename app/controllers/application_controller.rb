class ApplicationController < ActionController::Base
  	protect_from_forgery
  	include :devise
  	
	before_filter :authenticate_rails_user!

end
