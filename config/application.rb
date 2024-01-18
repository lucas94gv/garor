require_relative "boot"

require "rails/all"

module Garor
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w(assets tasks))

    config.api_only = true

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
