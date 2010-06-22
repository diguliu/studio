class BandSessionsController < ApplicationController
  def new
    @band_session = BandSession.new
  end

  def create
    @band_session = BandSession.new(params[:band_session])
    if @band_session.save
      flash[:notice] = "Successfully logged in!"
      redirect_to root_url
    else
      render :action => :new
    end
  end

  def destroy
    current_band_session.destroy
    flash[:notice] = "Successfully logged out!"
    redirect_to root_url
  end
end
