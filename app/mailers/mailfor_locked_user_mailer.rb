class MailforLockedUserMailer < ApplicationMailer
	ENV = YAML.load_file("#{Rails.root}/email_settings.yml")
	 default from: ENV["DEFAULT_EMAIL_FROM"]
  layout 'mailer'

   def lock_user_email(user,reason)
    url  = ENV['HOST']
    @user = user
    @reason = reason
<<<<<<< HEAD
    @url = url.concat '/report_to_unlock'.concat("?id=#{@user.id}")
=======
    @url = url.concat('/report_to_unlock').concat('?id=').concat(@user.id)
>>>>>>> 4fb758bf578c202d11311efc804ca89c4c4189a3
    mail(to: user.email, subject: "You have been blocked")
  end
end
