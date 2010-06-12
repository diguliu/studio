class AgendasController < ApplicationController
  # GET /agendas
  # GET /agendas.xml
  def index
    @agendas = Agenda.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agendas }
    end
  end

  # GET /agendas/1
  # GET /agendas/1.xml
  def show
    @agenda = Agenda.find(params[:id])
    @equips = Equip.find(:all)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agenda }
    end
  end

  # GET /agendas/new
  # GET /agendas/new.xml
  def new
    @agenda = Agenda.new
    @bands = Band.find(:all)
    @services = Service.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agenda }
    end
  end

  # GET /agendas/1/edit
  def edit
    @agenda = Agenda.find(params[:id])
    @bands = Band.find(:all)
    @services = Service.find(:all)
  end

  # POST /agendas
  # POST /agendas.xml
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

  # PUT /agendas/1
  # PUT /agendas/1.xml
  def update
    @agenda = Agenda.find(params[:id])

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

  # DELETE /agendas/1
  # DELETE /agendas/1.xml
  def destroy
    @agenda = Agenda.find(params[:id])
    @agenda.destroy

    respond_to do |format|
      format.html { redirect_to(agendas_url) }
      format.xml  { head :ok }
    end
  end

  def add_equip
    @equip = Equip.find(params[:equip][:id])
    @agenda = Agenda.find(params[:agenda][:id])

    respond_to do |format|
      if @agenda.add_equip(@equip, params[:internal_rent][:start], params[:duration])
        flash[:notice] = "Equipment added to the agenda."
        format.html {redirect_to(@agenda)}
        format.xml {head :ok}
      else
        flash[:notice] = "Failed to add the equipment to the agenda."
        format.html {redirect_to(@agenda)}
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def remove_equip
    @equip = Equip.find(params[:equip][:id])
    @agenda = Agenda.find(params[:agenda][:id])

    respond_to do |format|
      if @agenda.remove_equip(@equip)
        flash[:notice] = "Equipment removed from the agenda."
        format.html {redirect_to(@agenda)}
        format.xml {head :ok}
      else
        flash[:notice] = "Failed to remove the equipment from the agenda."
        format.html {redirect_to(@agenda)}
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def cancel
    @agenda = Agenda.find(params[:id])

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
end
