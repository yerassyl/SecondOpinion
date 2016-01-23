class CallBacksController < ApplicationController
  load_and_authorize_resource
  before_action :set_callback, only: [:show]


  def index

  end

  def create
    @call_back = CallBack.new(callback_params)

    respond_to do |format|
      if @call_back.save
          format.js
      else
          format.js {render json: @call_back.errors, status: :unprocessable_entity }
      end
    end

  end

  def show
  end


  private

  def set_callback
    @call_back = CallBack.find(params[:id])
  end

  def callback_params
    params.require(:call_back).permit(:name,:country,:phone,:language,:email,:specialization,:message,:didAgree,:code)
  end


end

