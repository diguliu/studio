class EquipsController < ApplicationController
  filter_resource_access

  def index
    @equips = Equip.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @equips }
    end
  end

  def show
    @equip = Equip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @equip }
    end
  end

  def new
    @equip = Equip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @equip }
    end
  end

  def edit
    @equip = Equip.find(params[:id])
  end

  def create
    @equip = Equip.new(params[:equip])

    respond_to do |format|
      if @equip.save
        flash[:notice] = 'Equip was successfully created.'
        format.html { redirect_to(@equip) }
        format.xml  { render :xml => @equip, :status => :created, :location => @equip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @equip.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @equip = Equip.find(params[:id])

    respond_to do |format|
      if @equip.update_attributes(params[:equip])
        flash[:notice] = 'Equip was successfully updated.'
        format.html { redirect_to(@equip) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @equip.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @equip = Equip.find(params[:id])
    @equip.destroy

    respond_to do |format|
      format.html { redirect_to(equips_url) }
      format.xml  { head :ok }
    end
  end

  def current_user
    current_band || current_client
  end
end
