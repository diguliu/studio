class PeopleController < ApplicationController
  filter_resource_access

  def index
    @people = Person.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @person }
    end
  end

  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  def edit
  end

  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        current_user.people << @person
        flash[:notice] = 'Member was successfully added.'
        format.html { redirect_to(current_user) }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update_attributes(params[:person])
        flash[:notice] = 'Member was successfully updated.'
        format.html { redirect_to(@person) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @person.destroy

    respond_to do |format|
      format.html { redirect_to current_user }
      format.xml  { head :ok }
    end
  end

  def current_user
    current_band || current_client
  end
end
