# frozen_string_literal: true

source 'https://rubygems.org'

# Ruby and rails
ruby '3.3.0'
gem 'rails', '~> 7.1.3'

# Database
gem 'pg', '~> 1.1'

# Server
gem 'bootsnap', require: false
gem 'puma', '>= 5.0'

# Data / time
gem 'tzinfo-data', platforms: %i[windows jruby]

# Build JSON APIs
gem 'jbuilder'

# Environment variables
gem 'figaro', '~> 1.1', '>= 1.1.1'

# Syntax
gem 'rubocop', '~> 1.60', '>= 1.60.1'

# Auth
gem 'devise', '~> 4.9', '>= 4.9.3'
gem 'devise-jwt', '~> 0.11.0'

# Api
gem 'rack-cors', '~> 2.0', '>= 2.0.1'

# Testing
gem 'rswag', '~> 2.13'

# Multi-Tenancy
gem 'acts_as_tenant', '~> 1.0', '>= 1.0.1'

group :development, :test do
  # Debug
  gem 'debug', require: false, platforms: %i[mri windows]
  # Testing
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
  gem 'faker', '~> 3.2', '>= 3.2.3'
  gem 'rspec-rails', '~> 6.1'
end

group :development do
end

group :test do
  # Testing
  gem 'capybara', '~> 3.39', '>= 3.39.2'
end
