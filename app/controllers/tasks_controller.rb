class TasksController < ApplicationController
	before_filter :priorytety, :only => [:new, :edit, :show ]
	before_filter :sidebar
  # GET /tasks/
  # GET /tasks.xml
  #require 'act_as_taggable'
  def index
    @complete = params[:complete]
    @tag = params[:tag]

    if not @tag.blank?
      @tasks = Task.find_tagged_with(@tag)
    elsif @complete.nil?
      @complete = false
      @tasks = Task.all(:conditions => ["complete = ?", @complete],:order => "priority DESC, created_at ASC" )
    else
      @complete = true
      @tasks = Task.all(:conditions => ["complete = ?", @complete],:order => "updated_at DESC")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new
	@projects = Project.all.inject([]) {|tab, val| tab << [val.name, val.id] }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to(@task) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
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
