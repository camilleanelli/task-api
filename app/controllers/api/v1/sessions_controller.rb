require "jwt"

module Api
  module V1
    class SessionsController < ApplicationController
      SECRET_KEY = Rails.application.credentials.secret_key_base

      def create
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
          token = generate_token(@user)
          render json: { token: token, user: { id: @user.id, email: @user.email } }, status: :created
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      def destroy
        render json: { message: "Logged out successfully" }, status: :ok
      end

      private

      def generate_token(user)
        payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
        JWT.encode(payload, SECRET_KEY)
        # encode already needs a payload and a secret key, then return a string token
      end
    end
  end
end
