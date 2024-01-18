# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

module Garor
  # Application-wide configuration settings for the Rails application.
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w[assets tasks])

    config.api_only = true

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
