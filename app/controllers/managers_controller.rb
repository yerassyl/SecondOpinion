class ManagersController < ApplicationController

  def index
    @call_backs = CallBack.all.page(params[:page])
  end

  def show

  end

  private


end
