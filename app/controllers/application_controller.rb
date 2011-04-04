# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'gcal4ruby'

class ApplicationController < ActionController::Base
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  include GCal4Ruby

  layout 'index'
  before_filter :set_facebook_session
  helper_method :facebook_session
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def authenticate
    @account = Service.new()
    @account.debug = true
    @account.authenticate('roadrunneronrails@gmail.com', 'grateurdunet')
  end
  
	def require_login
		unless logged_in?
			flash[:error] = "Vous ne pouvez pas accéder à cette page sans être connécté !"
			redirect_back_or_default('/')
		end
	end

	def require_admin
		unless logged_in? && current_user.type == "Admin"
			flash[:error] = "Vous devez être connécté en tant qu'admin pour accéder à cette page !"
			redirect_back_or_default('/')
		end
	end
  
end

