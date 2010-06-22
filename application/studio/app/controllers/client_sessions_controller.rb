class ClientSessionsController < ApplicationController
  def new
    @client_session = ClientSession.new
  end

  def create
    @client_session = ClientSession.new(params[:client_session])
    if @client_session.save
      flash[:notice] = "Login successful!"
      redirect_to root_url
    else
      render :action => :new
    end
  end

  def destroy
    current_client_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to root_url
  end
end
