class TopicsController < ApplicationController
	
	before_filter :require_login, :except => [:index, :show]
	
  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = Topic.new(params[:topic])
		@topic.user_id = session[:user_id]
		
    respond_to do |format|
      if @topic.save
      	if request.xhr?
      		format.html { render :partial => 'topic'}
				else
        	format.html { redirect_to(@topic, :notice => 'Topic was successfully created.') }
        	format.xml  { render :xml => @topic, :status => :created, :location => @topic }
        end
      else
       	if request.xhr?
      		format.html { render :partial => 'new_form'}
				else
      	  format.html { render :action => "new" }
        	format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(@topic, :notice => 'Topic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(topics_url) }
      format.xml  { head :ok }
    end
  end
  
  def show_new_form
  	if request.xhr?
  		render :partial => 'new_form'
  	else
  		redirect_to :action => :new
		end
  end
end
