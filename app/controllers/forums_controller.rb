class ForumsController < ApplicationController	
	
	before_filter :require_login, :except => [:index, :show]
	
  # GET /forums
  # GET /forums.xml
  def index
    @forums = Forum.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.xml
  def show
    @forum = Forum.find(params[:id])
		@topics = Topic.find_all_by_forum_id(@forum.id)
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum }
    end
  end

  # GET /forums/new
  # GET /forums/new.xml
  def new
    @forum = Forum.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum }
    end
  end

  # GET /forums/1/edit
  def edit
    @forum = Forum.find(params[:id])
  end

  # POST /forums
  # POST /forums.xml
  def create
    @forum = Forum.new(params[:forum])
		@forum.user_id = session[:user_id]
		
    respond_to do |format|
      if @forum.save
       	if request.xhr?
					format.html { render :partial => 'forum' }
       	else
      	  format.html { redirect_to( :action => :index , :notice => 'Forum was successfully created.') }
        	format.xml  { render :xml => @forum, :status => :created, :location => @forum }
        end
      else
       	if request.xhr?
      	  format.html { render :partial => 'new_form' }
       	else	  
	   	    format.html { render :action => "new" }
  	   	  format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
  	   	end
      end
    end
  end

  # PUT /forums/1
  # PUT /forums/1.xml
  def update
    @forum = Forum.find(params[:id])

    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        format.html { redirect_to(@forum, :notice => 'Forum was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.xml
  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to(forums_url) }
      format.xml  { head :ok }
    end
  end
  
  def show_create_forum_form
		if request.xhr?
	  	render :partial => 'new_form'
	  else
	  	redirect_to :action => :new
	  end
  end
end
