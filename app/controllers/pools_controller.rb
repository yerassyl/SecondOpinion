class PoolsController < ApplicationController
  load_and_authorize_resource

  # default pool
  def index
   # doctor_specialization_id = current_user.doctor.specializations.first.id
    @medical_situations = MedicalSituation.where(inPool: true, doctor_id: nil)
                              .page(params[:page]).per(10)
    # @medical_services = @medical_situations.each do |medical_situation|
    #   medical_situation.medical_services
    # end
    #@medical_services = MedicalService.where(in_pool: true, doctor_id: nil).page(params[:page]).per(10)
  end

  private


end
