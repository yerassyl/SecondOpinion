class LandingPageController < ApplicationController

  def index
    @client_call_back = CallBack.new
  end


end
