class DoctorsController < ApplicationController

  load_and_authorize_resource

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)

    if !User.find_by(email: @doctor.email)
      @user = User.new(name: params[:doctor][:name], email: params[:doctor][:email], password: 12345678)
      if @doctor.save and @user.save
        flash[:success] = I18n.t('doctor_has_been_registered') + '' + @doctor.email
        redirect_to managers_path
      else
        render 'new'
      end
    else
      flash[:error] = I18n.t('client_registration.user_with_that') + ' ' +@doctor.email + ' ' + I18n.t('client_registration.email_is_taken')
      render 'new'
    end

  end



  private

  def doctor_params
    params.require(:doctor).permit(:name,:email,:phone_number, :address, :resume, :resume_cache)
  end


end
