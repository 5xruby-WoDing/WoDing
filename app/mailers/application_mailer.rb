# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Woding@gmail.com'
  layout 'mailer'
end
