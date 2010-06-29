class ClientsController < ApplicationController
  filter_resource_access

  def index
    @clients = Client.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @client }
    end
  end

  def new
    @client = Client.new
    @people = Person.find(:all)
    @clients = Client.find(:all)

    @clients.each do |client|
      @people.delete_if {|person| person.id == client.person_id}
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client }
    end
  end

  def edit
    @people = Person.find(:all)
    @clients = Client.find(:all)

    @clients.each do |client|
      @people.delete_if {|person| person.id == client.person_id}
    end
    @people << Person.find(@client.person_id)
  end

  def create
    @client = Client.new(params[:client])
    @people = Person.find(:all)
    @clients = Client.find(:all)

    @clients.each do |client|
      @people.delete_if {|person| person.id == client.person_id}
    end

    respond_to do |format|
      if @client.save
        flash[:notice] = 'Client was successfully created.'
        format.html { redirect_to(@client) }
        format.xml  { render :xml => @client, :status => :created, :location => @client }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update_attributes(params[:client])
        flash[:notice] = 'Client was successfully updated.'
        format.html { redirect_to(@client) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @client.destroy

    respond_to do |format|
      format.html { redirect_to(clients_url) }
      format.xml  { head :ok }
    end
  end

  def show_rent
    @external_rent = ExternalRent.find(params[:rent_id])
    @equips = Equip.find(:all)
    @equip = @external_rent.equip

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @external_rent }
    end
  end

  def new_rent
    @equips = Equip.find(:all)
    @external_rent = ExternalRent.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @client }
#    end

  end

  def create_rent
    @equips = Equip.find(:all)
    @external_rent = ExternalRent.new(params[:external_rent])
    @external_rent.client_id = params[:id]
    @external_rent.status = "reserved"
    @external_rent.price = 0

    respond_to do |format|
      if @external_rent.save
        flash[:notice] = 'Rent was successfully created.'
        format.html { redirect_to(:action => "show_rent", :id => @external_rent.id) }
        format.xml  { render :xml => @external_rent, :status => :created, :location => @external_rent }
      else
        format.html { render :action => "new_rent" }
        format.xml  { render :xml => @external_rent.errors, :status => :unprocessable_entity }
      end
    end
  end

  def cancel_rent
    @external_rent = ExternalRent.find(params[:rent_id])

    respond_to do |format|
      if @external_rent.cancel
        flash[:notice] = "Rent canceled."
        format.html {redirect_to({:action=> "show_rent", :id => @client.id, :rent_id => @xternal_rent.id})}
        format.xml {head :ok}
      else
        flash[:notice] = "Failed to cancel rent."
        format.html {redirect_to({:action=> "show_rent", :id => @client.id, :rent_id => @xternal_rent.id})}
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def current_user
    current_band || current_client
  end

end
