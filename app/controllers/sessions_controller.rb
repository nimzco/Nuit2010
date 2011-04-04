# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # render new.erb.html
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = 'Connexion r&eacute;ussie'
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = 'Vous avez &eacute;t&eacute; d&eacute;connect&eacute;.'
    redirect_back_or_default('/')
  end
  
# TODO VIRER CA !  
  def authenticate_google
    if not session[:username] or not session[:password]
      redirect_to :action => :login and return
    end
    @account = Service.new()
    @account.debug = true
    @account.authenticate(session[:username], session[:password])
    @calendars = service.calendars
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Vous ne pouvez pas vous connecter en tant que '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
