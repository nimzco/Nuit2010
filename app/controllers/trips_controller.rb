class TripsController < ApplicationController

	before_filter :require_login, :except => [:index, :show, :search]

  # GET /trips
  # GET /trips.xml
  def index
	@trips = Trip.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trips }
    end
  end
  
	def search
		if !params[:start_address].nil? || !params[:end_address].nil?
			@date = params[:start_date]["(3i)"] + '/' +  params[:start_date]["(2i)"] + '/' + params[:start_date]["(1i)"]
	    @trips = Trip.find(:all, :conditions => ["start_address LIKE ? AND end_address LIKE ? AND start_date > ? ", "%#{params[:start_address]}%", "%#{params[:end_address]}%", @date.to_date])
		else
			@trips = Trip.all
		end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trips }
    end
	end
	
	def add_passenger
		@trip = Trip.find(params[:trip_id])
	  @trip.users << User.find_by_id(params[:user_id])

    respond_to do |format|
      if @trip.save
		 		flash[:notice] = 'Vous avez été ajouté au trajet'
				format.html { redirect_to(:controller => "trips", :action => 'show', :id => @trip.id) }
        format.xml  { render :xml => @trip, :status => :created, :location => @trip }
      else
		 		flash[:error] = 'Il y a eu un problème.'
        format.html { redirect_to :action => "show", :id => @trip.id }
        format.xml  { render :xml => @trip.errors, :status => :unprocessable_entity }
      end
    end

	end

	def add_step
		@trip = Trip.find(params[:id])
		@trip.steps << Step.create(:trip_id => @trip.id , :step_address => params[:step])
    respond_to do |format|
	    if @trip.save
	    	flash[:notice] = "Etape correctement ajouté"
	      format.html { redirect_to :action => "show", :id => @trip.id }
		    format.xml  { render :xml => @trip, :status => :created, :location => @trip }
	    else
 		 		flash[:error] = 'Il y a eu un problème.'
	       format.html { redirect_to :action => "show", :id => @trip.id }
		     format.xml  { render :xml => @trip.errors, :status => :unprocessable_entity }
	    end
    end
	end


	def propose_step
		@trip = Trip.find(params[:id])
		@trip.step_requests << StepRequest.create(:trip_id => params[:id], :user_id => current_user.id, :step_address => params[:step_request].to_s)

    respond_to do |format|
	    if @trip.save
	    	flash[:notice] = "Etape correctement proposé"
	      format.html { redirect_to :controller => "trips", :action => "show", :id => params[:id] }
	      format.xml  { render :xml => @trip, :status => :created, :location => @trip }
	    else
		 		flash[:error] = 'Il y a eu un problème.'
	      format.html { redirect_to :action => "show", :id => @trip.id }
	      format.xml  { render :xml => @trip.errors, :status => :unprocessable_entity }
	    end
    end
  end	

  def propose_driver
 		@trip = Trip.find(params[:id])
		@trip.driver_requests << DriverRequest.create(:trip_id => params[:id], :user_id => current_user.id)
    respond_to do |format|
	    if @trip.save
	    	flash[:notice] = "Proposition faites"
	      format.html { redirect_to :controller => "trips", :action => "show", :id => params[:id] }
	      format.xml  { render :xml => @trip, :status => :created, :location => @trip }
	    else
		 		flash[:error] = 'Il y a eu un problème.'
	      format.html { redirect_to :action => "show", :id => @trip.id }
	      format.xml  { render :xml => @trip.errors, :status => :unprocessable_entity }
	    end
    end
  end


  # GET /trips/1
  # GET /trips/1.xml
  def show
  	if params[:id] != "search"
	    @trip = Trip.find(params[:id])
		end
    respond_to do |format|
 	  	if params[:id] != "search"
	      format.html # show.html.erb
  	    format.xml  { render :xml => @trip }
  	  else 
	  	  format.html {redirect_to :controller => "trips", :action => "index" }
  	  end
    end
  end

  # GET /trips/new
  # GET /trips/new.xml
  def new
    @trip = Trip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trip }
    end
  end

  def accept_driver
	 dr =  DriverRequest.find(params[:id])
	 dr.trip.driver = dr.user
	 dr.user.save
	 dr.trip.save
	 redirect_to :controller => 'users', :action => 'dashboard', :id => dr.user_id
	end

	def accept_step
	 dr =  StepRequest.find(params[:id])
	 step = Step.new
	 step.step_address = dr.step_address
	 step.save
	 dr.trip.steps << step
	 dr.trip.save
	 redirect_to :controller => 'users', :action => 'dashboard', :id => dr.user_id
	end
	
  
  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
  end

  # POST /trips
  # POST /trips.xml
  def create
    @trip = Trip.new(params[:trip])
	@trip.seat = params[:trip][:seat].to_i + 1
	
	if params[:trip][:on_demand] == 'Passager'
		@trip.on_demand = true
		@trip.driver = nil
	else
		@trip.on_demand = false
		@trip.driver = current_user
	end
    respond_to do |format|
      if @trip.save
		  @trip.users << current_user
		  @trip.save
        format.html { redirect_to(@trip, :notice => 'Le trajet à correctement été enregistré') }
        format.xml  { render :xml => @trip, :status => :created, :location => @trip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trips/1
  # PUT /trips/1.xml
  def update
    @trip = Trip.find(params[:id])

    respond_to do |format|
      if @trip.update_attributes(params[:trip])
        format.html { redirect_to(@trip, :notice => 'Trip was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.xml
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to(trips_url) }
      format.xml  { head :ok }
    end
  end  
end
