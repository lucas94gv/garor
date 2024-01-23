# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    cif { Faker::Code.unique.isbn }
  end
end
