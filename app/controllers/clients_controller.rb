class ClientsController < ApplicationController
  def index
    # get all patients that belong to that client
  end

  # accept and create client account, then send message to the provided email
  def accept
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
      redirect_to root_path
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
