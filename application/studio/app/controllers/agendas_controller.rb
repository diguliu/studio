class AgendasController < ApplicationController
  filter_resource_access

  def index
    @agendas = Agenda.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agendas }
    end
  end

  def show
    @equips = Equip.find(:all)
    @internal_rent = InternalRent.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agenda }
    end
  end

  def new
    @agenda = Agenda.new
    @bands = Band.find(:all)
    @services = Service.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agenda }
    end
  end

  def edit
    @bands = Band.find(:all)
    @services = Service.find(:all)
  end

  def create
    @agenda = Agenda.new(params[:agenda])
    @agenda.status = "reserved"
    @agenda.total_price = 0
    @bands = Band.find(:all)
    @services = Service.find(:all)

    respond_to do |format|
      if @agenda.save
        flash[:notice] = 'Agenda was successfully created.'
        format.html { redirect_to(@agenda) }
        format.xml  { render :xml => @agenda, :status => :created, :location => @agenda }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @bands = Band.find(:all)
    @services = Service.find(:all)

    respond_to do |format|
      if @agenda.update_attributes(params[:agenda])
        flash[:notice] = 'Agenda was successfully updated.'
        format.html { redirect_to(@agenda) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @agenda.destroy

    respond_to do |format|
      format.html { redirect_to(agendas_url) }
      format.xml  { head :ok }
    end
  end

  def add_equip
    @internal_rent= InternalRent.new(params[:internal_rent])
    @internal_rent.agenda_id = @agenda.id
    year = @agenda.start.year
    month = @agenda.start.month
    day = @agenda.start.day
    time = Time.gm(year, month, day, params[:date][:hour], params[:date][:minute])
    @internal_rent.start = time

    respond_to do |format|
      if @internal_rent.save
        flash[:notice] = "Equipment added to the agenda."
        format.html {redirect_to(@agenda)}
        format.xml {head :ok}
      else
        flash[:notice] = "Failed to add the equipment to the agenda."
        format.html {redirect_to(@agenda)}
        format.xml  { render :xml => @internal_rent.errors, :status => :unprocessable_entity }
      end
    end
  end

  def remove_equip
    @internal_rent = InternalRent.find_by_equip_id(params[:internal_rent][:equip_id])

    respond_to do |format|
      if @agenda.remove_equip(@internal_rent)
        flash[:notice] = "Equipment removed from the agenda."
        format.html {redirect_to(@agenda)}
        format.xml {head :ok}
      else
        flash[:notice] = "Failed to remove the equipment from the agenda."
        format.html {redirect_to(@agenda)}
        format.xml  { render :xml => @internal_rent.errors, :status => :unprocessable_entity }
      end
    end
  end

  def cancel
    respond_to do |format|
      if @agenda.cancel
        flash[:notice] = "Agenda canceled."
        format.html {redirect_to(@agenda)}
        format.xml {head :ok}
      else
        flash[:notice] = "Failed to cancel agenda."
        format.html {redirect_to(@agenda)}
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def current_user
    current_band || current_client
  end
end
