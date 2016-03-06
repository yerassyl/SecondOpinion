class ManagersController < ApplicationController

  load_and_authorize_resource

  # index loads incoming callback requests initially
  def index
    @call_backs = CallBack.order(created_at: 'DESC').page(params[:page])
  end

  # rejected callbacks
  def rejected
    @call_backs = CallBack.where(rejected: true).order(created_at: 'DESC').page(params[:page])
    #render @call_backs, change: 'call_backs'
  end

  # accepted callbacks
  def accepted
    @call_backs = CallBack.where(accepted: true).order(created_at: 'DESC').page(params[:page])
  end


  def show

  end

  private


end
