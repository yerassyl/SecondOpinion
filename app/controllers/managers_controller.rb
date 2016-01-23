class ManagersController < ApplicationController
  before_action :authenticate_user!


  def index
    @call_backs = CallBack.all.page(params[:page])
    authorize! :index, current_user
  end

  def show

  end

  private


end
