class HomeController < ApplicationController
  def index
  end

  def current_user
    current_band || current_client
  end
end
