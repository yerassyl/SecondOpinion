class PoolsController < ApplicationController
  load_and_authorize_resource

  # default pool
  def index
    @filterrific = initialize_filterrific(
      MedicalSituation.joins("INNER JOIN medical_situation_statuses ON 
                                medical_situation_statuses.id = medical_situations.medical_situation_status_id")
                              .where("medical_situation_statuses.name = 'In pool'"),
      params[:filterrific],
      select_options: {
        sorted_by: MedicalSituation.options_for_sorted_by,
        with_specialization_id: Specialization.options_for_select
      },
      persistence_id: 'shared_key'
    ) or return

    @medical_situations = @filterrific.find.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
    # @medical_situations = MedicalSituation.where(inPool: true, doctor_id: nil)
    #                           .page(params[:page]).per(10)
  end

  private


end
