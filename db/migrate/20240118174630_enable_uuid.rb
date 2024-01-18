# frozen_string_literal: true

# EnableUuid will enable the extension pgcrypto
class EnableUuid < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto'
  end
end
