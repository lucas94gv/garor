# frozen_string_literal: true

require 'swagger_helper'
require 'devise/jwt/test_helpers'
require 'rails_helper'

RSpec.describe('Users API', type: :request) do
  path '/signup' do
    post 'Create a user' do
      tags 'Users'

      parameter name: :user,
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    email: { type: :string },
                    password: { type: :string },
                    company_id: { type: :string },
                    role: { type: :string }
                  },
                  required: %w[email password company_id role]
                }

      FactoryBot.create(:company) unless Company.first

      total_users = User.count

      response '201', 'OK' do
        let(:user) do
          { user: { email: Faker::Internet.email(domain: 'gmail.com'), password: 'abc123.',
                    company_id: Company.first.id, role: 'employee' } }
        end

        run_test! do |response|
          parsed_response = JSON.parse(response.body)
          expect(User.count).to eq(total_users+1)
          expect(parsed_response.keys.count).to(eq(7))
          expect(parsed_response.keys).to(eq(['id', 'email', 'company_id', 'role', 'created_at', 'updated_at', 'jti']))
          expect(parsed_response['email']).to eq(user[:user][:email])
          expect(parsed_response['role']).to eq('employee')
        end        
      end

      response '422', 'Unprocessable entity without values' do
        let(:user) { { user: { email: '', password: '', company_id: '', role: '' } } }

        run_test! do |response|
          parsed_response = JSON.parse(response.body)
          expect(User.count).to eq(total_users)
          expect(parsed_response['errors']).to be_present
        end
      end

      response '422', 'Unprocessable entity with repeated email' do

        FactoryBot.create(:employee) unless User.first

        let(:user) { { user: { email: User.first.email, password: 'abc123.', company_id: Company.first.id } } }

        run_test! do |response|
          parsed_response = JSON.parse(response.body)
          expect(User.count).to eq(total_users)
          expect(parsed_response['errors']).to be_present
        end
      end
    end
  end
end
