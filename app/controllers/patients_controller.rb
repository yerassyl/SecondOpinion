class PatientsController < ApplicationController

  load_and_authorize_resource

  before_action :set_patient, only: [:new_medical_situation]

  def new
    @patient = Patient.new
  end

  def show
    @medical_situation = MedicalSituation.new
    @medical_situations = MedicalSituation.where('patient_id = ? AND closed=?', @patient.id, false).limit(1).order(created_at: :desc)
    build_nested_attributes
  end

  def create
    @patient = Patient.new(patient_params)
    @patient.client_id = current_user.client.id
    if @patient.save
      flash.now[:success] = I18n.t('patient_module.patient_registered')
      redirect_to @patient
    else
      render 'new'
    end
  end

  def new_medical_situation
    @medical_situation = MedicalSituation.new
  end

  def create_medical_situation
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
        format.json {render json: @medical_situation.errors, status: :unprocessable_entity}
        format.html {
          flash[:alert] = 'Sorry, There were problems creating medical situations'
          redirect_to patient_path(@patient_id)
        }
        @patient = Patient.find(@patient_id)
      end
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

  # list all family histories
  def familyHistories
    render :json => @familyHistories = {
        familyHistories: FamilyHistory.where(patient_id: @patient.id),
        form: {
            action: create_familyHistory_patients_path,
            csrf_param:  request_forgery_protection_token,
            csrf_token:  form_authenticity_token
        }
    }
  end

  def create_familyHistory

  end

  def delete_familyHistory

  end

  def allergies
    render :json => @allergies = {
        allergiesList: Allergy.where(patient_id: @patient.id),
        form: {
            action:  create_allergy_patients_path,
            csrf_param:  request_forgery_protection_token,
            csrf_token:  form_authenticity_token
        }
    }
  end

  # add allergy to patient's profile
  def create_allergy
    @allergy = Allergy.new(allergy_params)
    if @allergy.save
      render json: {
          allergiesList: Allergy.where(patient_id: params[:allergy][:patient_id])
      }
    end
  end

  def delete_allergy
    if Allergy.delete(params[:allergy_id])
      render json: {status: :ok}
    else
      render json: {status: :error}
    end
  end


  def diseases
    render :json => @diseases = {
        diseasesList: Disease.where(patient_id: @patient.id),
        form: {
            action: create_disease_patients_path,
            csrf_param: request_forgery_protection_token,
            csrf_token: form_authenticity_token
        }
    }
  end

  def create_disease
    @disease = Disease.new(disease_params)
    if @disease.save
      render json: {
          diseasesList: Disease.where(patient_id: params[:disease][:patient_id])
      }
    end
  end

  def delete_disease
    if Disease.delete(params[:disease_id])
      render json: {status: :ok}
    else
      render json: {status: :error}
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient])
  end

  def build_nested_attributes
    @medical_situation.medications.build
    @medical_situation.lab_tests.build
    @medical_situation.other_documents.build
  end

  def patient_params
    params.require(:patient).permit(:firstname,:middlename,:lastname,:birthday,:maritial_status,:gender,:email,
                                    :telephone,:cellphone,:emergency_person,:emergency_person_phone, :client_id)
  end

  def allergy_params
    params.require(:allergy).permit(:name,:patient_id)
  end

  def disease_params
    params.require(:disease).permit(:diagnose,:condition,:treatment,:other, :patient_id)
  end

  def medical_situation_params
    params.require(:medical_situation).permit(:reason, :patient_id,
      medications_attributes:[:id,:_destroy,:name,:dose,:per_day,:other,:medical_situation_id],
      lab_tests_attributes: [:id,:_destroy,:name,:description, :medical_situation_id,:file,:file_cache],
      other_documents_attributes: [:id,:_destroy, :name, :description, :medical_situation_id, :file, :other_document_cache]
    )
  end

end
