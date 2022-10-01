class ApplicationMailer < ActionMailer::Base
  default from: "Moto Share <#{ENV.fetch('GMAIL_USERNAME', nil)}>"
  layout 'mailer'
end
