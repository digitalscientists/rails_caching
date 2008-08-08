class WidgetsController < ApplicationController
   cache_sweeper :app_sweeper
  # GET /widgets
  # GET /widgets.xml
  #caches_action :index
  caches_page :show
  def index
    @widgets = Rails.cache.fetch(cache_key,:expires_in=>CACHE_TIMEOUT) do
      Widget.find(:all).paginate(:page => @page, :per_page => 100)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @widgets }
    end
  end

  # GET /widgets/1
  # GET /widgets/1.xml
  def show
    @widget = Widget.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @widget }
    end
  end

  # GET /widgets/new
  # GET /widgets/new.xml
  def new
    # Caching  Widget Columns (0.001861)   SHOW FIELDS FROM `widgets`
    # for default cache_timeout set in development.rb
    @widget = cache("widget:new",:expires_in=> CACHE_TIMEOUT) do 
      Widget.new
    end
    expire_action(:controller => "widgets", :action => "index")
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @widget }
    end
  end

  # GET /widgets/1/edit
  def edit
    @widget = Widget.find(params[:id])
  end

  # POST /widgets
  # POST /widgets.xml
  def create
    @widget = Widget.new(params[:widget])
    respond_to do |format|
      if @widget.save
        flash[:notice] = 'Widget was successfully created.'
        format.html { redirect_to(@widget) }
        format.xml  { render :xml => @widget, :status => :created, :location => @widget }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @widget.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /widgets/1
  # PUT /widgets/1.xml
  def update
    @widget = Widget.find(params[:id])
    respond_to do |format|
      if @widget.update_attributes(params[:widget])
        flash[:notice] = 'Widget was successfully updated.'
        format.html { redirect_to(@widget) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @widget.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /widgets/1
  # DELETE /widgets/1.xml
  def destroy
    @widget = Widget.find(params[:id])
    @widget.destroy

    respond_to do |format|
      format.html { redirect_to(widgets_url) }
      format.xml  { head :ok }
    end
  end
end
