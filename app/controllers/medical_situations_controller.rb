class MedicalSituationsController < ApplicationController
  load_and_authorize_resource

  # all medical situations
  def index
    @medical_situations = MedicalSituation.order(created_at: 'desc').limit(10)
    @doctors = Doctor.all
  end

  # in pool medical situations
  def in_pool
    @medical_situations = MedicalSituation.where(inPool: true).order(created_at: 'desc')
    @doctors = Doctor.all
  end

  def not_in_pool
    @medical_situations = MedicalSituation.where(inPool: false).order(created_at: 'desc')
    @doctors = Doctor.all
  end


  def create
    @patient_id = params[:patient]
    @medical_situation = MedicalSituation.new(medical_situation_params)
    @medical_situation.patient_id = @patient_id
    respond_to do |format|
      if @medical_situation.save
        format.json { render json: @medical_situation, status: :created}
        format.html {
          flash[:success] = I18n.t('medical_situation_added')
          redirect_to patient_path(@patient_id)
        }
      else
        format.json { render json: @medical_situation.errors, status: :unprocessable_entity}
        format.html {
          flash[:alert] = 'Sorry, There were problems creating medical situations'
          #flash[:alert] = @medical_situation.errors.full_messages
          redirect_to patient_path(@patient_id)
        }
        @patient = Patient.find(@patient_id)
      end
    end
  end

  # manager send medical_situation to pool
  # ajax
  def send_to_pool
    @medical_situation = MedicalSituation.find(params[:medical_situation][:medical_situation_id])
    # if doctor is assigned then assign doctor and do not send to pool
    if params[:medical_situation][:doctor_id].present?
      @medical_situation.update(doctor_id: params[:medical_situation][:doctor_id], price: params[:medical_situation][:price], inPool: true)
    else
      # else send to pool
      @medical_situation.update(doctor_id: nil,price: params[:medical_situation][:price], inPool: true)
    end
  end

  # load more medical situations that belong to that patient
  def load_more
    if params[:med_id]
      @med_situations = MedicalSituation.where('id < ?', params[:med_id]).limit(5)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # only doctor can take any medical situation from pool
  # taken situation appears doctors list
  def take
     doctor_id = params[:doctor_id]
     # medical_situation is loaded by cancancan via passing id of medical_situation as parameter to url
     if @medical_situation.update(doctor_id: doctor_id)
       flash[:success] = I18n.t('you_took_medical_situation')
       redirect_to pools_path
     end
  end

  private

  def medical_situation_params
    params.require(:medical_situation).permit(:reason, :price, :paid, :patient_id, :doctor_id, :inPool, :medical_situation_id,
                                              medications_attributes:[:id,:_destroy,:name,:dose,:per_day,:other,:medical_situation_id],
                                              lab_tests_attributes: [:id,:_destroy,:name,:description, :medical_situation_id,:file,:file_cache],
                                              other_documents_attributes: [:id,:_destroy, :name, :description, :medical_situation_id, :file, :other_document_cache]
    )
  end
end
