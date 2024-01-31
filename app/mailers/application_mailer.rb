# frozen_string_literal: true

# ApplicationMailer handles email delivery for the application.
# It serves as the base mailer class from which other mailers inherit.
#
# All email-related functionality, such as defining mailer methods and
# configuring default settings, should be implemented here.
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
