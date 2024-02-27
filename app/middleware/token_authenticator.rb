# frozen_string_literal: true

# Middleware for token-based authentication.
# This middleware verifies JWT tokens sent in the Authorization header
# for API requests, allowing access only to routes within the 'api/v1'
# namespace. It checks the validity of the token and ensures that
# the user is authenticated before allowing access to protected routes.
class TokenAuthenticator
  def initialize(app)
    @app = app
  end

  def call(env)
    if protected_route?(env['PATH_INFO'])
      token = extract_token_from_header(env['HTTP_AUTHORIZATION'])
      if token_valid?(token)
        @app.call(env)
      else
        [401, { 'Content-Type' => 'application/json' }, [{ error: 'Unauthorized' }.to_json]]
      end
    else
      @app.call(env)
    end
  end

  private

  def extract_token_from_header(header)
    header.to_s.split(' ').last
  end

  def token_valid?(token)
    decoded_token = JWT.decode(token, ENV['devise_jwt_secret_key'])
    user_jti = decoded_token.first['jti']
    User.find_by(jti: user_jti).present?
  rescue JWT::DecodeError => e
    puts "Error al decodificar el token: #{e.message}"
    false
  end

  def protected_route?(path)
    path.start_with?('/api/v1/')
  end
end
