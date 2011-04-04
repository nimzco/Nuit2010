class RatesController < ApplicationController
	
	before_filter :require_login, :except => [:indew, :show]
	before_filter :require_owner, :except => [:index, :show, :create, :new, :rate_it, :edit_rate_it]
	
	# GET /rates
	# GET /rates.xml
	def index
		# TODO redirect_to somewhere !?
		respond_to do |format|
			format.html # index.html.erb
			format.xml { render :xml => @rates }
		end
	end

	# GET /rates/1
	# GET /rates/1.xml
	def show
		@rate = Rate.find(params[:id])
		# TODO redirect according withe the type of rates
		respond_to do |format|
			format.html { redirect_to(:controller => 'users', :action => 'profile', :id => @rate.user_id) }
			format.xml { render :xml => @rate }
		end
	end

	# GET /rates/new
	# GET /rates/new.xml
	def new
		if params[:user_id].nil?
			flash[:error] = "Quelqu'un doit être spécifié"
			redirect_to :controller => 'rates', :action => 'index'
		else
			@rate = Rate.new
			@rate.user_id = params[:user_id]
			
			respond_to do |format|
				format.html # new.html.erb
				format.xml { render :xml => @rate }
			end
		end
	end

	# GET /rates/1/edit
	def edit
		@rate = Rate.find(params[:id])
	end

	# POST /rates
	# POST /rates.xml
	def rate_it
		@rate = Rate.new
		@rate.user_id = params[:user_id]
	
		@rate.author = current_user
		@rate.rate = params[:score]
		
		respond_to do |format|
			if @rate.save
				format.html { redirect_to(:controller => 'users', :action => 'profile', :id => @rate.user_id) }
				format.xml { render :xml => @rate, :status => :created, :location => @rate }
			else
				format.html { render :action => 'index' }
				format.xml { render :xml => @rate.errors, :status => :unprocessable_entity }
			end
		end
	end

	
	# POST /rates
	# POST /rates.xml
	def edit_rate_it
		@rate = Rate.find(:first, :conditions => ['authorid = ? and user_id = ?', current_user.id, params[:user_id]])
		@rate.rate = params[:score]
		
		respond_to do |format|
			if @rate.save
				format.html { redirect_to(:controller => 'users', :action => 'profile', :id => @rate.user_id) }
				format.xml { render :xml => @rate, :status => :created, :location => @rate }
			else
				format.html { render :action => 'index' }
				format.xml { render :xml => @rate.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	# PUT /rates/1
	# PUT /rates/1.xml
	def updateRt
		@rate = Rate.find(params[:id])

		respond_to do |format|
			if @rate.update_attributes(params[:rate])
				# TODO redirect where the rate has benn posted
				format.html { redirect_to(:controller => 'users', :action => 'profile', :id => @rate.user_id, :notice => 'La Note a été ajouté') }
				format.xml { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml { render :xml => @rate.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /rates/1
	# DELETE /rates/1.xml
	def destroy
		@rate = Rate.find(params[:id])
		rate_id = @rate.id
		@rate.destroy

		respond_to do |format|
			# TODO redirect where the rate has benn posted
			format.html { redirect_to(rates_url) }
			format.xml { head :ok }
		end
	end
	
	private

	def require_owner
		rate = Rate.find(params[:id])
		unless logged_in? && (current_user.type == 'Admin' || current_user.id == rate.authorid)
			flash[:error] = "Ce n'est pas votre note"
			redirect_to :controller => 'users', :action => 'profile', :id => rate.user_id
		end
	end
end
