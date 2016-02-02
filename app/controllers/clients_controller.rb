class ClientsController < ApplicationController
  before_action :authenticate_user!

  def index
    # get all patients that belong to that client
  end

  # accept and create client account, then send message to the provided email
  def accept
    @call_back_id = params[:id]
    @call_back = CallBack.find(@call_back_id)
    @client_role = Role.find_by(name: 'client')

    if !User.find_by(email: @call_back.email)
      @client_user = User.new(
          name: @call_back.name,
          email: @call_back.email,
          password: '12345678'
      )

      if @client_user.save
        @client_role_assignment = Assignment.create(
            user_id: @client_user.id,
            role_id: @client_role.id
        )
        if @client_role_assignment
          @call_back.update(accepted: true)
          flash[:success] = I18n.t('client_registration.client_accepted')
        end
      else
        if @client_user.errors.any?
          flash[:error] = @client_user.errors
        end
      end
    else
      flash[:error] = I18n.t('client_registration.user_with_that') + @call_back.email + I18n.t('client_registration.email_is_taken')
    end
    @call_back = params[:call_back]
    @client = Client.create(
                        name: @call_back.name,
                        email: @call_back.email,
                        password: '12345678'
    )
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
      redirect_to root_pasth
    else
      flash[:info] = "Something went wrong"
      render 'new'
    end
  end

  private

  def client_params
    params.require(:user).permit(:name,:email,:password)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
