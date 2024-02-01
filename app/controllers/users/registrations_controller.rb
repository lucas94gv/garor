# frozen_string_literal: true

module Users
  # Controller for user registrations, extending Devise's RegistrationsController.
  # This controller allows customization of the sign-up process, including additional
  # parameters like :company_id and :role. Customization is done through the
  # configure_sign_up_params method, where additional parameters are permitted.
  # Devise provides a solid foundation, and this controller is tailored to accommodate
  # specific requirements of the application.
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation company_id role])
    end
  end
end
