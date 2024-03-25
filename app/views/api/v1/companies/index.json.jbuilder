# frozen_string_literal: true

json.array! @companies do |company|
  json.id company.id
  json.cif company.cif
end
