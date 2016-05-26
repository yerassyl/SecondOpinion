class ManagersController < ApplicationController

  load_and_authorize_resource
  before_action :set_manager, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]

  # index loads incoming callback requests initially
  def index
    @call_backs = CallBack.where(accepted: false, rejected: false).order(created_at: 'DESC').page(params[:page])
  end

  # rejected callbacks
  def rejected
    @call_backs = CallBack.where(rejected: true).order(created_at: 'DESC').page(params[:page])
    #render @call_backs, change: 'call_backs'
  end

  # accepted callbacks
  def accepted
    @call_backs = CallBack.where(accepted: true).order(created_at: 'DESC').page(params[:page])
  end


  def show

  end

  def edit
  end

  def update

    if params[:manager].has_key? 'password'
      if @user.valid_password?(params[:manager][:current_password])
        if params[:manager][:password].eql? params[:manager][:password_confirmation]
          @user.update_attribute(:password, params[:manager][:password])
          sign_in @user, :bypass => true
          flash[:success] = I18n.t('manager_profile_updated') + ' ' + @user.email
          redirect_to '/managers'
        else
          #flash[:error] = I18n.t['forms.password_confirmation_failure']
          render 'edit'
        end
      else
        #flash[:error] = I18n.t['forms.auth.invalid_password']
        render 'edit'
      end
    elsif @manager.update_attributes(manager_params)
      flash[:success] = I18n.t('manager_profile_updated') + ' ' + @user.email
      redirect_to @manager
    else
      render 'edit'
    end
  end

  private
    def set_manager
      @manager = Manager.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    def manager_params
      params.require(:manager).permit(:email)
    end

end
