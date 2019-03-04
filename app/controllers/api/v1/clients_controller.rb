class Api::V1::ClientsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
    render json: {messages: 'hello'}
  end

  def profile
    render json: { client: ClientSerializer.new(@client) }, status: :accepted
  end

  def create
    @client = Client.create(client_params)
    if @client.valid?
      @token = encode_token(client_id: @client.id)
      render json: { client: ClientSerializer.new(@client), jwt: @token }, status: :created
    else
      render json: { messages: @client.errors.full_messages }, status: :not_acceptable
    end
  end

  def update
    if @client.update(client_patch_params)
      render json: { client: ClientSerializer.new(@client) }, status: :created
    else
      render json: { messages: @client.errors.full_messages }, status: :not_acceptable
    end
  end

  private

  def client_params
    params.permit(:name, :email, :password)
  end

  def client_patch_params
    params.permit(:name, :email, :avatar, :phone_number)
  end
end
