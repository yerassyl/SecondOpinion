class PoolsController < ApplicationController
  load_and_authorize_resource

  # default pool
  def index
    @medical_situations = MedicalSituation.where(inPool: true, doctor_id: nil).page(params[:page]).per(10)
  end

  private


end
