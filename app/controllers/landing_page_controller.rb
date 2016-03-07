class LandingPageController < ApplicationController
  
  def index
    @client_call_back = CallBack.new
  end

  def access_denied

  end

  def leave_callback
  	
  end

end
