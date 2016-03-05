class DoctorsController < ApplicationController

  load_and_authorize_resource

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)

    if !User.find_by(email: @doctor.email)
      @user = User.new(name: params[:doctor][:name], email: params[:doctor][:email], password: 12345678)
      if @user.save and @doctor.save
        flash.now[:success] = I18n.t('doctor_has_been_registered')
        redirect_to managers_path
      else
        render 'new'
      end
    else
      flash.now[:error] = I18n.t('client_registration.user_with_that') + ' ' +@doctor.email + ' ' + I18n.t('client_registration.email_is_taken')
      render 'new'
    end

  end



  private

  def doctor_params
    params.require(:doctor).permit(:name,:email,:phone_number, :address, :resume, :resume_cache)
  end


end
