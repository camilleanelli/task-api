module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json
        before_action :configure_sign_up_params, only: [ :create ]

        def create
          build_resource(sign_up_params)
          if resource.save
            yield resource if block_given?
            respond_with(resource)
          else
            clean_up_passwords resource
            set_minimum_password_length
            respond_with(resource)
          end
        end

        private

        def configure_sign_up_params
          devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :last_name, :email ])
        end

        def respond_with(resource, _opts = {})
          resource.valid?
          if resource.persisted?
            render json: {
              status: { code: 200, message: "Compte cr\u00E9\u00E9 avec succ\u00E8s." },
              data: Api::V1::UserSerializer.new(resource)
            }, status: :ok
          else
            render json: {
              status: { message: "L'utilisateur n'a pas pu être créé. #{resource.errors.full_messages.to_sentence}" }
            }, status: :unprocessable_entity
          end
        end

        def sign_up_params
          params.require(:user).permit(:email, :password, :password_confirmation, :name, :last_name)
        end
      end
    end
  end
end
