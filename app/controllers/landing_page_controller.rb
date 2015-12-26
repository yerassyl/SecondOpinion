class LandingPageController < ApplicationController

  def index
    @client_call_back = ClientCallBack.new
  end


  def create_client_callback

  end

end
