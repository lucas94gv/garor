# frozen_string_literal: true

# RackSessionsFix module provides a workaround for specific issues related to Rack sessions in Devise.
# It addresses compatibility or functionality issues that may arise with certain configurations
# or versions of Rack middleware and Devise.
# This module can be included in the Rails application to patch and resolve such issues
# while maintaining the functionality of Devise's session management.
module RackSessionsFix
  extend ActiveSupport::Concern

  # FakeRackSession provides a mock implementation of Rack session management for testing purposes.
  # It mimics the behavior of a Rack session, allowing developers to simulate session
  # data and behavior in tests without relying on a real session store.
  # This class is particularly useful for unit and integration testing of Rack middleware
  # and web applications that rely on session management.
  class FakeRackSession < Hash
    def enabled?
      false
    end

    def destroy; end
  end
  included do
    before_action :set_fake_session

    private

    def set_fake_session
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end
