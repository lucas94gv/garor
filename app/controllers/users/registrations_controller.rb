# frozen_string_literal: true

module Users
  # RegistrationsController manages user registration and account creation using Devise.
  # It inherits from Devise's registrations controller and provides actions for
  # signing up new users, editing account details, and deleting accounts.
  # Customizations to the registration process can be added here, such as additional
  # validation or steps in the sign-up flow.
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation company_id role])
    end
  end
end
