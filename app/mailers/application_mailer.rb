class ApplicationMailer < ActionMailer::Base
  default from: YAML.load_file("#{Rails.root}/email_settings.yml")['DEFAULT_EMAIL_FROM']
  layout 'mailer'

   
end
