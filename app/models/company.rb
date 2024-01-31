# frozen_string_literal: true

# Model representing a company with associated attributes and behavior
class Company < ApplicationRecord
  validates :cif, presence: true, uniqueness: true, length: { is: 9 }
end
