class CommentsController < ApplicationController
	
	before_filter :require_login, :except => [:indew, :show]
	
	before_filter :require_owner, :except => [:index, :show, :create, :new]
	
	# GET /comments
	# GET /comments.xml
	def index
		# TODO redirect_to somewhere !?
		respond_to do |format|
			format.html # index.html.erb
			format.xml { render :xml => @comments }
		end
	end

	# GET /comments/1
	# GET /comments/1.xml
	def show
		@comment = Comment.find(params[:id])
		# TODO redirect according withe the type of comments
		respond_to do |format|
			format.html { redirect_to(:controller => 'users', :action => 'profile', :id => @comment.user_id) }
			format.xml { render :xml => @comment }
		end
	end

	# GET /comments/new
	# GET /comments/new.xml
	def new
		if params[:user_id].nil?
			flash[:error] = "Quelqu'un doit être spécifié"
			redirect_to :controller => 'comments', :action => 'index'
		else
			@comment = Comment.new
			@comment.user_id = params[:user_id]
		end
		respond_to do |format|
			format.html # new.html.erb
			format.xml { render :xml => @comment }
		end
	end

	# GET /comments/1/edit
	def edit
		@comment = Comment.find(params[:id])
	end

	# POST /comments
	# POST /comments.xml
	def create
		@comment = Comment.new(params[:comment])
		@comment.author = current_user
		
		respond_to do |format|
			if @comment.save
				format.html { redirect_to(:controller => 'users', :action => 'profile', :id => @comment.user_id, :notice => 'Commentaire ajouté !') }
				format.xml { render :xml => @comment, :status => :created, :location => @comment }
			else
				format.html { render :action => "new" }
				format.xml { render :xml => @comment.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /comments/1
	# PUT /comments/1.xml
	def updateCom
		@comment = Comment.find(params[:id])
		respond_to do |format|
			if @comment.update_attributes(params[:comment])
				format.html { redirect_to(:controller => 'users', :action => 'profile', :id => @comment.user_id, :notice => 'Commentaire modifié !') }
				format.xml { render :xml => @comment, :status => :created, :location => @comment }
				format.xml { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml { render :xml => @comment.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /comments/1
	# DELETE /comments/1.xml
	def destroy
		@comment = Comment.find(params[:id])
		comment_id = @comment.id
		@comment.destroy

		respond_to do |format|
			# TODO redirect where the comment has benn posted
			format.html { redirect_to(:controller => 'users', :action => 'profile', :id => @comment.user_id) }
			format.xml { head :ok }
		end
	end
	
	private 

	def require_owner
		comment = Comment.find(params[:id])
		unless logged_in? && (current_user.type == 'Admin' || current_user.id == comment.authorid)
			flash[:error] = "Ce n'est pas votre commentaire"
			redirect_to :controller => 'users', :action => 'profile', :id => comment.user_id
		end
	end
end
