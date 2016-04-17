class DoctorsController < ApplicationController

  load_and_authorize_resource

  def index
    @doctors = Doctor.order(created_at: 'DESC').page(params[:page])
  end

  def new
    @doctor = Doctor.new
  end

  def show

  end

  # fix doctor validation
  def create
    @doctor = Doctor.new(doctor_params)
    @doctor_role = Role.find_by(name: 'doctor')

    @user = User.new(name: params[:doctor][:name], email: params[:doctor][:email], password: 12345678)
    if @user.save
      @doctor.user_id = @user.id
      if @doctor.save
        if Assignment.create( user_id: @user.id,  role_id: @doctor_role.id )
          flash[:success] = I18n.t('doctor_has_been_registered') + ' ' + @doctor.email
          redirect_to managers_path
        end
      else

      end
    else
      render 'new'
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(:name,:email,:phone_number, :address, :resume, :resume_cache)
  end


end
