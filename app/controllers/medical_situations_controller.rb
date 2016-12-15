class MedicalSituationsController < ApplicationController
  load_and_authorize_resource

  before_action :set_filterrific, only: [:index]
  before_action :set_medical_situation, only: [:show, :drop]

  # all medical situations
  def index
    @medical_situations = @filterrific.find.page(params[:page]).per(10)
    @doctors = Doctor.all
    @medical_situation_statuses = MedicalSituationStatus.all
    respond_to do |format|
      format.js
      format.html
    end
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # show medical situation in expanded mode with it's medical_services and other related information
  # such as notes, reports etc
  def show
    #@medical_situation should be loaded
    @medical_services = @medical_situation.medical_services
    @medical_situation_statuses = MedicalSituationStatus.all
    @medical_service = MedicalService.new
    @medications = @medical_situation.medications
    @lab_tests = @medical_situation.lab_tests
    @other_documents = @medical_situation.other_documents
    @medical_situation_reports = @medical_situation.medical_situation_reports
    @medical_situation_report = MedicalSituationReport.new
    #@medical_service.medical_service_documents.build
  end

  def create
    @patient_id = params[:patient]
    @patient = Patient.find(@patient_id)
    @medical_situation = MedicalSituation.new(medical_situation_params)
    @medical_situation.patient_id = @patient_id
    @patient.amount_due += @medical_situation.price
    @medical_situation.medical_situation_status = MedicalSituationStatus.find_by(name: 'Not in pool')

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
        @patient
      end
    end
  end

  # manager send medical_situation to pool
  # ajax
  def send_to_pool
    @medical_situation = MedicalSituation.find(params[:medical_situation][:medical_situation_id])
    # if doctor is assigned then assign doctor and do not send to pool
    # refactor/rewrite this one later
    @medical_situation.update(medical_situation_params)
    # if params[:medical_situation][:doctor_id].present?
    #   @medical_situation.update(doctor_id: params[:medical_situation][:doctor_id], fee: params[:medical_situation][:fee], inPool: true)
    # else
    #   # else send to pool
    #   @medical_situation.update(doctor_id: nil, fee: params[:medical_situation][:fee], inPool: true)
    # end

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
     if @medical_situation.update(doctor_id: doctor_id, 
          medical_situation_status: MedicalSituationStatus.find_by(name: 'Doctor reviewing'))
       flash[:success] = I18n.t('you_took_medical_situation')
       redirect_to pools_path
     end
  end

  # doctor can drop medical situation which then goes back to Pool with 'Returned' status
  def drop
    if @medical_situation.update(doctor_id: nil,
          medical_situation_status: MedicalSituationStatus.find_by(name: 'Returned'))
      flash[:success] = I18n.t('you_dropped_medical_situtation')
      @doctor = params[:doctor_id]
      redirect_to doctor_path @doctor
    end
  end

  # doctor can submit report
  # js
  def submit_report
    @medical_situation_report = MedicalSituationReport.new(medical_situation_report_params)
    if @medical_situation_report.save
      @medical_situation_reports = MedicalSituation.find(@medical_situation_report.medical_situation_id).medical_situation_reports
    end
  end

  def send_to_patient
    if @medical_situation.update(medical_situation_status: MedicalSituationStatus.find_by(name: 'Waiting for patient'))
      flash[:success] = I18n.t('sent_to_patient')
      redirect_to @medical_situation
    end
  end

  def send_to_doctor
    if @medical_situation.update(medical_situation_status: MedicalSituationStatus.find_by(name: 'Doctor reviewing'))
      flash[:success] = I18n.t('sent_to_doctor')
      redirect_to @medical_situation
    end
  end

  private

    def medical_situation_params
      params.require(:medical_situation).permit(:reason, :price, :fee, :paid, :patient_id, :doctor_id, :medical_situation_status_id,
                                                :specialization_id, :manager_sets_fee_attr, :is_urgent,
                                                medications_attributes:[:id,:_destroy,:name,:dose,:per_day,:other,:medical_situation_id],
                                                lab_tests_attributes: [:id,:_destroy,:name,:description, :medical_situation_id,:file,:file_cache],
                                                other_documents_attributes: [:id,:_destroy, :name, :description, :medical_situation_id, :file, :other_document_cache]
      )
    end

    def medical_situation_report_params
      params.require(:medical_situation_report).permit(:medical_situation_id, :doctor_id, :name, :description, :file, :file_cache)
    end

    def set_medical_situation
      @medical_sitation = MedicalSituation.find(params[:id])
    end

    def set_filterrific
      @filterrific = initialize_filterrific(
        MedicalSituation,
        params[:filterrific],
        select_options: {
          sorted_by: MedicalSituation.options_for_sorted_by_manager,
          with_specialization_id: Specialization.options_for_select,
          with_medical_situation_status_id: MedicalSituationStatus.options_for_select
        },
        persistence_id: 'shared_key',
      ) or return
    end

end
