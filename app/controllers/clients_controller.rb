class ClientsController < ApplicationController
  load_and_authorize_resource
  before_action :set_client, only: [:edit, :update]

  def index
    # get all patients that belong to that client
    @patients = current_user.client.patients
  end

  def show
    
  end

  # accept and create client account, then send message to the provided email
  def accept
    @call_back_id = params[:callback_id]
    @call_back = CallBack.find(@call_back_id)
    @client_role = Role.find_by(name: 'client')

    if !User.find_by(email: @call_back.email)
      @user = User.new(
          name: @call_back.name,
          email: @call_back.email,
          password: '12345678'
      )
      if @user.save
        @client_role_assignment = Assignment.create(
            user_id: @user.id,
            role_id: @client_role.id
        )
        if @client_role_assignment
          @client = Client.create(
                              user_id: @user.id,
                              name: @call_back.name,
                              country: @call_back.country,
                              phone: @call_back.phone,
                              language: @call_back.language
          )
          @call_back.update(accepted: true)
          # send email message
          ClientMailer.welcome_email(@user).deliver_now
          flash.now[:success] = I18n.t('client_registration.client_accepted') + ' '+@user.email
        end
      else
        if @user.errors.any?
          flash.now[:error] = @user.errors
        end
      end
    else
      flash.now[:error] = I18n.t('client_registration.user_with_that') + @call_back.email + I18n.t('client_registration.email_is_taken')
    end

  end

  def reject
    @call_back = CallBack.find(params[:callback_id])
    call_back = CallBack.find(@call_back.id)
    call_back.update(rejected: true)
    flash[:alert] = I18n.t('you_rejected_callback') + @call_back.email
    redirect_to @call_back
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      @assignment = Assignment.new(user_id: @user.id, role_id: Role.find_by(name: 'client').id)
      @assignment.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to root_past
    else
      flash[:info] = "Something went wrong"
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = @client.user

    if @client.update_attributes(client_params)
      if params[:client][:password].blank?
        flash[:success] = I18n.t('client_profile_updated') + '' + @client.user.email
        redirect_to @client
      elsif @user.valid_password?(params[:client][:current_password])
        @user.update_attribute(:password, params[:client][:password])
        sign_in @user, :bypass => true
        flash[:success] = I18n.t('client_profile_updated') + '' + @client.user.email
        redirect_to @client
      else 
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name,:email,:country, :phone, :language)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
