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

  private

  def client_params
    params.require(:user).permit(:name,:email,:password)
  end

end
