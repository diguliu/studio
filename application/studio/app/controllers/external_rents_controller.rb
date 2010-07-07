class ExternalRentsController < ApplicationController
  filter_resource_access

  def show
    @client = @external_rent.client
    @equips = Equip.find(:all)
    @equip = @external_rent.equip

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @external_rent }
    end
  end

  def new
    @equips = Equip.find(:all)
    @client = current_user
    @external_rent = ExternalRent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client }
    end
  end

  def create
    @client = current_user
    @equips = Equip.find(:all)
    @external_rent = ExternalRent.new(params[:external_rent])
    @external_rent.client_id = @client.id
    @external_rent.status = "reserved"
    @external_rent.total_price = 0

    respond_to do |format|
      if @external_rent.save
        flash[:notice] = 'Rent was successfully created.'
        format.html { redirect_to @external_rent }
        format.xml  { render :xml => @external_rent, :status => :created, :location => @external_rent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @external_rent.errors, :status => :unprocessable_entity }
      end
    end
  end

  def cancel

    respond_to do |format|
      if @external_rent.cancel
        flash[:notice] = "Rent canceled."
        format.html {redirect_to @external_rent }
        format.xml {head :ok}
      else
        flash[:notice] = "Failed to cancel rent."
        format.html {redirect_to @external_rent }
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def current_user
    current_band || current_client
  end
end
