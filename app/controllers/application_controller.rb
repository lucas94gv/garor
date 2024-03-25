# frozen_string_literal: true

# ApplicationController serves as the base controller for the entire API.
# It encapsulates common functionality, such as authentication and authorization,
# and provides a centralized place for handling global concerns.
# In a Rails API-only context, it focuses on managing API-specific concerns,
# ensuring that all controllers inherit essential behaviors for building a robust and secure API.
# Developers can extend this controller to implement custom global logic or
# leverage built-in features to streamline API development.
class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers

  respond_to :json

  set_current_tenant_through_filter

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_tenant

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email avatar])
  end

  # Set the current tenant based on company of user.
  # The tenant is set using the before_action callback.
  def set_tenant
    company = current_user&.company
    set_current_tenant(company)
  end
end
