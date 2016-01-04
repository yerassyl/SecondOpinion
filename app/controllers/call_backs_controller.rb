class CallBacksController < ApplicationController

  def index

  end

  def create
    @call_back = CallBack.new(callback_params)

    respond_to do |format|
      if @call_back.save
          format.js
      else
          format.json {render json: @call_back.errors, status: :unprocessable_entity }
      end
    end

  end


  private
  def callback_params
    params.require(:call_back).permit(:name,:country,:phone,:language,:email,:specialization,:message,:didAgree,:code)
  end


end

