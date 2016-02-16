class PatientsController < ApplicationController
  load_and_authorize_resource

  before_action :set_patient, only: [:new_medical_history]

  def new
    @patient = Patient.new
  end

  def show
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

  def new_medical_history
    @medical_history = MedicalHistory.new
    build_nested_attributes
  end

  def create_medical_history
    @patient_id = params[:patient]
    @medical_history = MedicalHistory.new(medical_history_params)
    if @medical_history.save
      flash.now[:medical_history_added] = I18n.t('patient_module.medical_history.medical_history_added')
      redirect_to patient_path(@patient_id)
    else
      @patient = Patient.find(@patient_id)
      #build_nested_attributes
      render 'new_medical_history'
    end
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
    @medical_history.diseases.build
    @medical_history.medications.build
    @medical_history.allergies.build
    @medical_history.lab_tests.build
    @medical_history.other_documents.build
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

  def medical_history_params
    params.require(:medical_history).permit(:reason,:smoke,:drink,:pregnant,
      diseases_attributes:[:id,:_destroy,:diagnose,:condition,:treatment,:other,:medical_history_id],
      medications_attributes:[:id,:_destroy,:name,:dose,:per_day,:other,:medical_history_id],
      allergies_attributes: [:id,:_destroy,:name],
      lab_tests_attributes: [:id,:_destroy,:name,:description,:file],
      other_documents_attributes: [:id,:_destroy, :name, :description, :file]
    )
  end

end
