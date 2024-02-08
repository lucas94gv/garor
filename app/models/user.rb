# frozen_string_literal: true

# User model for managing authentication and user-related features.
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates_presence_of :company_id, :encrypted_password

  belongs_to :company
end
