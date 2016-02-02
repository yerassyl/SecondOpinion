class ManagersController < ApplicationController

  load_and_authorize_resource

  def index
    @call_backs = CallBack.where(accepted: false).order(created_at: 'DESC').page(params[:page])
  end

  def show

  end

  private


end
