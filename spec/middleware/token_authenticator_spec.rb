# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TokenAuthenticator do
  let(:app) { double('app') }
  let(:middleware) { TokenAuthenticator.new(app) }

  describe '#call' do
    context 'when accessing protected route' do
      let(:valid_token) { JWT.encode({ jti: user_jti }, ENV['devise_jwt_secret_key']) }
      let(:invalid_token) { 'invalid_token' }
      let(:user) { FactoryBot.create(:employee) }
      let(:user_jti) { SecureRandom.uuid }
      let(:env) { { 'PATH_INFO' => '/api/v1/companies', 'HTTP_AUTHORIZATION' => "Bearer #{token}" } }

      context 'with valid token' do
        let(:token) { valid_token }

        before do
          allow(User).to receive(:find_by).with(jti: user_jti).and_return(user)
        end

        it 'calls the next middleware' do
          expect(app).to receive(:call).with(env)
          middleware.call(env)
        end
      end

      context 'with invalid token' do
        let(:token) { invalid_token }

        it 'returns unauthorized response' do
          response = middleware.call(env)
          expect(response[0]).to eq(401)
          expect(response[2]).to eq([{ error: 'Unauthorized' }.to_json])
        end
      end

      context 'without token' do
        let(:token) { nil }

        it 'returns unauthorized response' do
          response = middleware.call(env)
          expect(response[0]).to eq(401)
          expect(response[2]).to eq([{ error: 'Unauthorized' }.to_json])
        end
      end
    end

    context 'when accessing non-protected route' do
      let(:env) { { 'PATH_INFO' => '/other_route' } }

      it 'calls the next middleware' do
        expect(app).to receive(:call).with(env)
        middleware.call(env)
      end
    end
  end
end
