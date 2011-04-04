class GoogleMapsController < ApplicationController
	
	before_filter :require_login, :except => [:index, :show]
	
	# GET /google_maps
	# GET /google_maps.xml
	def index
		@google_maps = GoogleMap.all

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @google_maps }
		end
	end

	# GET /google_maps/1
	# GET /google_maps/1.xml
	def show
		@google_map = GoogleMap.find(params[:id])
		@marker = GoogleMarker.new

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @google_map }
			format.json  { render :json => @google_map }
		end
	end

	def createMarker
		google_map = GoogleMap.find(params[:id])
		@marker = GoogleMarker.new(params[:marker])
		@marker.google_map = google_map

		respond_to do |format|
			if @marker.save
				format.html { redirect_to(:action => 'show', :id => google_map.id, :last_marker => 1, :notice => 'Le marker a &eacute;t&eacute; ajout&eacute;') }
				format.xml  { render :xml => google_map, :status => :created, :location => google_map }
			else
				format.html { redirect_to(:action => 'show', :id => google_map.id, :last_marker => 1, :error => 'Les champs adrresse et titre sont obligatoires') }
				format.xml  { render :xml => google_map.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	# GET /google_maps/new
	# GET /google_maps/new.xml
	def new
		@google_map = GoogleMap.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @google_map }
		end
	end

	# GET /google_maps/1/edit
	def edit
		@google_map = GoogleMap.find(params[:id])
	end

	# POST /google_maps
	# POST /google_maps.xml
	def create
		@google_map = GoogleMap.new(params[:google_map])

		respond_to do |format|
			if @google_map.save
				format.html { redirect_to(@google_map, :notice => 'GoogleMap was successfully created.') }
				format.xml  { render :xml => @google_map, :status => :created, :location => @google_map }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @google_map.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /google_maps/1
	# PUT /google_maps/1.xml
	def update
		@google_map = GoogleMap.find(params[:id])

		respond_to do |format|
			if @google_map.update_attributes(params[:google_map])
				format.html { redirect_to(@google_map, :notice => 'GoogleMap was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @google_map.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /google_maps/1
	# DELETE /google_maps/1.xml
	def destroy
		@google_map = GoogleMap.find(params[:id])
		@google_map.destroy

		respond_to do |format|
			format.html { redirect_to(google_maps_url) }
			format.xml  { head :ok }
		end
	end
end
