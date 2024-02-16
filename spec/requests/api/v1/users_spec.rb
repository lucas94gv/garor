# frozen_string_literal: true

# rubocop:disable Metrics/Metrics/BlockLength

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

      FactoryBot.create(:company)

      response '201', 'OK' do
        let(:user) do
          { user: { email: Faker::Internet.email(domain: 'gmail.com'), password: 'abc123.',
                    company_id: Company.first.id, role: 'employee' } }
        end

        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:user) { { user: { email: '', password: '', company_id: '', role: '' } } }

        run_test!
      end
    end
  end
end
