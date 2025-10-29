module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        # Surcharge de l'action create
        def create
          # 1. Tente d'authentifier l'utilisateur
          puts warden.inspect
          self.resource = warden.authenticate!(auth_options)

          # 2. Si authentification réussie, signe l'utilisateur (pour Devise-JWT)
          sign_in(:user, resource)

          # 3. Répond avec succès (ancien code de respond_with)
          render json: {
            status: { code: 200, message: "Connexion r\u00E9ussie." },
            data: Api::V1::UserSerializer.new(resource).serializable_hash[:data][:attributes]
          }, status: :ok
        rescue StandardError => e
          # Si l'authentification warden échoue (e.g., email/password incorrect)
          # il lève une erreur, capturée ici pour appeler notre 401.
          respond_to_on_failure
        end

        private

        def sign_in_params
          params.require(:user).permit(:email, :password)
        end

        def respond_to_on_failure
          render json: {
            status: { code: 401, message: "Email ou mot de passe invalide." }
          }, status: :unauthorized
        end

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
