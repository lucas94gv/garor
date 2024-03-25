# frozen_string_literal: true

module Users
  # SessionsController handles user authentication sessions using Devise.
  # It provides actions for user sign in, sign out, and session management.
  # This controller inherits from Devise's sessions controller and overrides
  # some default behavior to customize the authentication flow as needed.
  class SessionsController < Devise::SessionsController
    include RackSessionsFix

    respond_to :json

    private

    def respond_with(_current_user, _opts = {})
      render json: {
        token: request.env['warden-jwt_auth.token']
      }, status: :ok
    end

    def respond_to_on_destroy
      if request.headers['Authorization'].present?
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, ENV['devise_jwt_secret_key']).first
        current_user = User.find(jwt_payload['sub'])
      end

      if current_user
        render json: { message: 'Logged out successfully.' }, status: :ok
      else
        render json: { message: "Couldn't find an active session." }, status: :unauthorized
      end
    end

    def encode_token(payload)
      JWT.encode(payload, ENV['devise_jwt_secret_key'])
    end
  end
end
