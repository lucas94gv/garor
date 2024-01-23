# frozen_string_literal: true

# Company model
class Company < ApplicationRecord
  validates :cif, presence: true, uniqueness: true, length: { is: 11 }
end
