# frozen_string_literal: true

module Api
  module V1
    # Controller to manage operations related to companies.
    class CompaniesController < ApplicationController
      before_action :authenticate_user!

      def index
        @companies = Company.all
      end
    end
  end
end
