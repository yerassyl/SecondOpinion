class LandingPageController < ApplicationController
  
  def landing_index
    @client_call_back = CallBack.new
    render layout: false
  end

  def access_denied

  end

  def leave_callback
    @callback = DoctorCallback.new
  end

  def send_resume
    @callback = DoctorCallback.new(callback_params)

    if @callback.save
      flash.now[:success] = I18n.t('Resume has sent')
      ResumeMailer.send_resume(@callback).deliver_later
      redirect_to root_path
    else
      render 'leave_callback'
    end   

  end

  private
    def callback_params
      params.require(:doctor_callback).permit(:name, :email, :resume, :resume_cache)
    end

end
