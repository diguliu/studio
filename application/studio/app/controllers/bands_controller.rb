class BandsController < ApplicationController
  filter_resource_access

  def index
    @bands = Band.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bands }
    end
  end

  def show
    @members = @band.people

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @band }
    end
  end

  def new
    @band = Band.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @band }
    end
  end

  def edit
  end

  def create
    @band = Band.new(params[:band])

    respond_to do |format|
      if @band.save
        flash[:notice] = 'Band was successfully created.'
        format.html { redirect_to(@band) }
        format.xml  { render :xml => @band, :status => :created, :location => @band }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @band.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @band.update_attributes(params[:band])
        flash[:notice] = 'Band was successfully updated.'
        format.html { redirect_to(@band) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @band.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @band.destroy

    respond_to do |format|
      format.html { redirect_to(bands_url) }
      format.xml  { head :ok }
    end
  end

  def current_user
    current_band || current_client
  end

end
