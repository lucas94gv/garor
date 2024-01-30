# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    cif { Faker::Company.spanish_organisation_number }
  end
end
