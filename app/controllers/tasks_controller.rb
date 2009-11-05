class TasksController < ApplicationController
	before_filter :priorytety, :only => [:new, :edit, :show ]
	#before_filter :sidebar
	before_filter :require_user
  # GET /tasks/
  # GET /tasks.xml

  def index
    @complete = params[:complete]
    projects = []
    unless params[:filter].blank?
      projects = Project.all(:conditions => ["UPPER(name) like ?",params[:filter].upcase+'%']).inject([]) {|tab, val| tab << val.id }
    end

    if @complete.nil?
      @complete = false
      if params[:filter].blank?
        @tasks = Task.all(:conditions => ["complete = ?", @complete],:order => "priority ASC, created_at ASC" )
      else
        @tasks = Task.all(:conditions => ["complete = ? AND project_id in (?)", @complete, projects],:order => "priority ASC, created_at ASC" )
      end
    else
      @complete = true
      if params[:filter].blank?
        @tasks = Task.all(:conditions => ["complete = ?", @complete],:order => "updated_at DESC")
      else
        @tasks = Task.all(:conditions => ["complete = ? AND project_id in (?)", @complete, projects],:order => "updated_at DESC")
      end
    end

  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new
    @projects = Project.all.inject([]) {|tab, val| tab << [val.name, val.id] }
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    if @task.save
      flash[:notice] = 'Task was successfully created.'
      redirect_to(@task) 
    else
      render :action => "new"
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      flash[:notice] = 'Task was successfully updated.'
      redirect_to(@task)
    else
      render :action => "edit"
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end

  private
  def priorytety
	@priorities = []
	for i in 1..3 do
		@priorities << [ENV[i.to_s], i]
	end
	#print @priorities[1]
  end

end
