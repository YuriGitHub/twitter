class MailforLockedUserMailer < ApplicationMailer
	ENV = YAML.load_file("#{Rails.root}/email_settings.yml")
	 default from: ENV[Rails.env]["DEFAULT_EMAIL_FROM"]
  layout 'mailer'

   def lock_user_email(user,reason)
    url  = ENV[Rails.env]['HOST']
    @user = user
    @reason = reason
    @url = url.concat '/report_to_unlock'.concat("?id=#{@user.id}")
    mail(to: user.email, subject: "You have been blocked")
  end
end
