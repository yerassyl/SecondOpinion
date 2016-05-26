class MedicalServicesController < ApplicationController
  load_and_authorize_resource

  before_action :set_medical_service, only: [:show, :update]

  # js
  def show
    @medical_service_documents = @medical_service.medical_service_documents
  end

  def create
    @medical_service = MedicalService.new(medical_service_params)
    @medical_service.save
  end

  # js
  def update
    @medical_service.update(medical_service_params)
  end

  # manager sets fee for doctors which is lower that price set by client
  def set_fee
    @medical_service = MedicalService.find(params[:medical_service][:id])
    @medical_service.update(medical_service_params)
    flash[:success] = I18n.t('fee_has_been_set')
  end

private

  def medical_service_params
    params.require(:medical_service).permit(:name,:description, :price, :fee, :medical_situation_id, :specialization_id,
                                            :manager_sets_fee_attr,
      medical_service_documents_attributes:[:id,:_destroy,:file,:file_cache,:name,:description,:medical_service_id]
    )
  end

  def set_medical_service
    @medical_service = MedicalService.find(params[:id])
  end

end
