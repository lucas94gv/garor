# frozen_string_literal: true

# This migration will enable the extension pgcrypto
class EnableUuid < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto'
  end
end
