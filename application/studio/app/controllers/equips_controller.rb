require "hpricot"

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
    @equip.destroy

    respond_to do |format|
      format.html { redirect_to(equips_url) }
      format.xml  { head :ok }
    end
  end

  def export_equips
    send_data(Equip.xml_equips, :type => "text/xml", :filename => "equips.xml")
  end

  def import_equips
    require "ap"
    if(request.post?)
      uploaded_file = params[:xml_file]
      xml = ""
      uploaded_file.each do |lines|
        xml << lines
      end
      doc = Hpricot(xml)
      invalid_equips_models = []
      (doc/"equipment").each do |equipment|
        ap (equipment/"model")
        ap (equipment/"model").inner_html
        #        begin
        #equip = Equip.new(:model => (equipment/"model").inner_html, 
        #                  :description => (equipment/"description").inner_html, 
        #                  :classification => (equipment/"classification").inner_html)
        #                        :internal_price => (equipment/"internal_price"),
        #                        :external_price => (equipment/"external_price"))
        #require "ap"
        #ap equip
        #equip.save
        #       rescue
        #        invalid_equips_models << (equipment/"model")
        #      end
      end
      if(!invalid_equips_models.blank?)
        flash[:error] = "The following equipment(s) were invalid: " + invalid_equips_models.join(', ')
      end
      redirect_to equips_path
    end
  end

  def current_user
    current_band || current_client
  end
end
