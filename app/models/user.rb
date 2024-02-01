# frozen_string_literal: true

# User model for managing authentication and user-related features.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable
end
