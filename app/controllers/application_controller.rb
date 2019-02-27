class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    # should store secret in env variable
    JWT.encode(payload, 'super_secret2')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 'super_secret2', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_client
    if decoded_token
      client_id = decoded_token[0]['client_id']
      @client = Client.find_by(id: client_id)
    end
  end

  def logged_in?
    !!current_client
  end

  def authorized
    render json: { messages: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
