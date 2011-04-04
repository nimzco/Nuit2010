class ComunitiesController < ApplicationController
  # GET /comunities
  # GET /comunities.xml
  def index
    @comunities = Comunity.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comunities }
    end
  end

	def search 
    @comunities = Comunity.find(:all, :conditions => ["name LIKE ?", "%#{params[:comunity]}%"])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comunities }
    end
	end
	
  # GET /comunities/1
  # GET /comunities/1.xml
  def show
   	if params[:id] != "search"
	    @comunity = Comunity.find(params[:id])
			@map = GoogleMap.new
			@map.title = 'Localisation de '+@comunity.name
			@map.address = @comunity.address
			@map.zoom = 7
			marker = GoogleMarker.new
			marker.title = @comunity.name
			marker.color = "blue"
			marker.address = @comunity.address
			@map.google_markers << marker
		end
    respond_to do |format|
    	if params[:id] != "search"
    	  format.html # show.html.erb
      	format.xml  { render :xml => @comunity }
      else
    	  format.html {redirect_to :controller => "comunities", :action => "index"}
      end
    end
  end

  # GET /comunities/new
  # GET /comunities/new.xml
  def new
    @comunity = Comunity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comunity }
    end
  end

  # GET /comunities/1/edit
  def edit
    @comunity = Comunity.find(params[:id])
  end

  # POST /comunities
  # POST /comunities.xml
  def create
    @comunity = Comunity.new(params[:comunity])

    respond_to do |format|
      if @comunity.save
        format.html { redirect_to(@comunity, :notice => 'Comunity was successfully created.') }
        format.xml  { render :xml => @comunity, :status => :created, :location => @comunity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comunity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comunities/1
  # PUT /comunities/1.xml
  def update
    @comunity = Comunity.find(params[:id])

    respond_to do |format|
      if @comunity.update_attributes(params[:comunity])
        format.html { redirect_to(@comunity, :notice => 'Comunity was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comunity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comunities/1
  # DELETE /comunities/1.xml
  def destroy
    @comunity = Comunity.find(params[:id])
    @comunity.destroy

    respond_to do |format|
      format.html { redirect_to(comunities_url) }
      format.xml  { head :ok }
    end
  end
end
