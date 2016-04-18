class DoctorsController < ApplicationController

  load_and_authorize_resource
  before_action :set_doctor, only: [:show, :update_resume]

  def index
    @doctors = Doctor.order(created_at: 'DESC').page(params[:page])
  end

  def new
    @doctor = Doctor.new
  end

  def show
    @medical_situations = @doctor.medical_situations
  end

  # fix doctor validation
  def create
    @doctor = Doctor.new(doctor_params)
    @doctor_role = Role.find_by(name: 'doctor')

    if !User.find_by(email: @doctor.email)
      @user = User.new(name: params[:doctor][:name], email: params[:doctor][:email], password: 12345678)
      if @user.save
        @doctor.user_id = @user.id
        if @doctor.save
          Assignment.create(
            user_id: @user.id,
            role_id: @doctor_role.id
          )
          flash[:success] = I18n.t('doctor_has_been_registered') + '' + @doctor.email
          redirect_to managers_path
        end
      else

      end
    else
      render 'new'
    end
  end

  def update
  end

  def update_resume
    @doctor.update_attribute(:resume, params[:doctor][:resume])
    flash[:success] = I18n.t('resume_updated')
    redirect_to @doctor
  end

  private

    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    def doctor_params
      params.require(:doctor).permit(:name,:email,:phone_number, :address, :resume, :resume_cache)
    end


end
