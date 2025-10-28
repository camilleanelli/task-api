module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        private

        def respond_with(resource, _opts = {})
          render json: {
            status: { code: 200, message: "Connexion r\u00E9ussie." },
            data: Api::V1::UserSerializer.new(resource).serializable_hash[:data][:attributes]
          }, status: :ok
        end

        def respond_to_on_destroy
          log_out_success && return if current_user

          log_out_failure
        end

        def log_out_success
          render json: { status: 200, message: "D\u00E9connexion r\u00E9ussie." }, status: :ok
        end

        def log_out_failure
          render json: { status: 401, message: "Token manquant ou invalide." }, status: :unauthorized
        end
      end
    end
  end
end
