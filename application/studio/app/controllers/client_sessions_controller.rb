class ClientSessionsController < ApplicationController
  def new
    if current_band || current_client
      flash[:notice] = "You are already logged in!"
      redirect_to root_url
    end
    @client_session = ClientSession.new
  end

  def create
    @client_session = ClientSession.new(params[:client_session])
    if @client_session.save
      flash[:notice] = "Successfully logged in!"
      redirect_to root_url
    else
      render :action => :new
    end
  end

  def destroy
    current_client_session.destroy
    flash[:notice] = "Successfully logged out!"
    redirect_to root_url
  end
end
