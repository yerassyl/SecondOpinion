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


  end

  private

  def client_params
    params.require(:user).permit(:name,:email,:password)
  end

end
