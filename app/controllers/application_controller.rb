class ApplicationController < ActionController::API
  SECRET_KEY = Rails.application.credentials.secret_key_base
  # this key is used for decode method of JWT like the encode method

  def authenticate_request!
    header  = request.headers["Authorization"]
    # take the token from the header
    token = header.split(" ").last if header
    begin
      # JWT.decode renders an array of hashes where first one is the user_id key/value
      decoded = JWT.decode(token, SECRET_KEY)[0]
      @current_user = User.find(decoded["user_id"])
    rescue JWT::DecodeError
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
