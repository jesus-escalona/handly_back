class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    client = Client.find_by(email: client_login_params[:email])
    # Client#authenticate comes from BCrypt
    if client && client.authenticate(client_login_params[:password])
      # encode token comes from ApplicationController
      token = encode_token(client_id: client.id)
      render json: { client: ClientSerializer.new(client), jwt: token }, status: :accepted
    else
      render json: { messages: ['Invalid email or password'] }, status: :unauthorized
    end
  end

  private

  def client_login_params
    # params { client: {clientname: 'Chandler Bing', password: 'hi' } }
    params.require(:user).permit(:email, :password)
  end
end
