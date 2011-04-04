class UsersController < ApplicationController

	before_filter :require_login, :except => [:new, :create, :profile, :link_user_accounts]
	
#	before_filter :require_owner, :except => [:new, :create, :profile, :link_user_accounts]

  # render new.rhtml
  def new
    @user = People.new
    @comunities = Comunity.find(:all, :order => :name)
  end
 
  def create
    logout_keeping_session!
    @user = People.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
	  # reset_session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = 'Merci, vous &ecirc;tes maintenant bien enregistr&eacute;!'
    else
      flash[:error]  = "Votre inscription a &eacute;chou&eacute;e. Veuillez r&eacute;essayer de vous inscrire ou contactez l'administrateur (lien en bas de page)"
      render :action => 'new'
    end
  end
  
	def profile
		@user = User.find(params[:id])
				
		if !@user.address.nil?
			@map = GoogleMap.new
			@map.title = 'Localisation de '+@user.name
			@map.address = @user.address
			
			# TODO en fonction du sujet
			if @user.type == 'People'
				@map.zoom = 6
			else
				@map.zoom = 12
			end
			
			marker = GoogleMarker.new
			marker.title = @user.name
			marker.color = "blue"
			marker.address = @user.address
			
			@map.google_markers << marker
		end
	end
	
	def dashboard
		trips = Trip.find(:all, :conditions => ['user_id = ? AND start_date >= ?', current_user.id, Time.now])
		@other_step_requests = []
		
		trips.each do |trip|
			@other_step_requests.concat(trip.step_requests)
		end
		
		trips_on_demand = Trip.find(:all, :conditions => ['on_demand = TRUE'])
		@other_driver_requests = []
		trips_on_demand.each do |trip|
			trip.users.each do |user|
				if user.id == current_user.id
					@other_driver_requests.concat(trip.driver_requests)
				end
			end
		end
		
	end
	
	def edit_profile
			@user = User.find(params[:id])
			respond_to do |format|
				format.html #{ redirect_to :controller => 'edit_profile', :id => @user.id}
				format.js { render :partial => 'edit_profile' }
			end
	end

	def update
		@user = User.find(params[:id])

    respond_to do |format|
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.address = params[:user][:address]
    @user.phone_number = params[:user][:phone_number]
    
      if @user.save #update_attributes(params[:user])
		flash[:notice] = "Profile mis à jour"
        format.html { redirect_to( :action => "profile", :id => params[:id], :notice => flash[:notice]) }
        format.xml  { head :ok }
        format.js 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end

	end

  def link_user_accounts
	  if self.current_user.nil?
	    #register with fb
	    logger.debug "The object is #{facebook_session}"
	    User.create_from_fb_connect(facebook_session.user)
	  else
	    #connect accounts
	    self.current_user.link_fb_connect(facebook_session.user.id) unless self.current_user.fb_user_id == facebook_session.user.id
	  end
	  redirect_to '/'
  end
  
# 	private
# 
# 	def require_owner
# 		unless logged_in? && (current_user.type == 'Admin' || current_user.id == params[:id])
# 			flash[:error] = "Ce n'est pas votre compte"
# 			redirect_to :controller => 'users', :action => 'profile', :id => params[:id]
# 		end
# 	end
  
end
