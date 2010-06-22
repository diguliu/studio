# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_band_session, :current_band

  private
    def current_band_session
      return @current_band_session if defined?(@current_band_session)
      @current_band_session = BandSession.find
    end

    def current_band
      return @current_band if defined?(@current_band)
      @current_band = current_band_session && current_band_session.band
    end


  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '23e920e58073d0312b239640d32d7807'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
