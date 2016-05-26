class DoctorsController < ApplicationController

  load_and_authorize_resource
  before_action :set_doctor, only: [:show, :update_resume, :edit, :update]
  before_action :set_user, only: [:edit, :update, :update_resume]

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

  def edit
  end

  def update
    if params[:doctor].has_key? 'password'
      if @user.valid_password?(params[:doctor][:current_password])
        if params[:doctor][:password].eql? params[:doctor][:password_confirmation]
          @user.update_attribute(:password, params[:doctor][:password])
          sign_in @user, :bypass => true
          flash[:success] = I18n.t('doctor_profile_updated') + ' ' + @doctor.email
          redirect_to @doctor
        else
          #flash[:error] = I18n.t['forms.password_confirmation_failure']
          render 'edit'
        end
      else
        #flash[:error] = I18n.t['forms.auth.invalid_password']
        render 'edit'
      end
    elsif @doctor.update_attributes(doctor_params)
      flash[:success] = I18n.t('doctor_profile_updated') + ' ' + @doctor.email
      redirect_to @doctor
    else
      render 'edit'
    end
  end

  def update_resume
    if @doctor.update_attribute(:resume, params[:doctor][:resume])
      flash[:success] = I18n.t('resume_updated')
      redirect_to @doctor
    end
  end

  private

    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    def doctor_params
      params.require(:doctor).permit(:name, :email, :phone_number, :address, :resume, :resume_cache)
    end


end
