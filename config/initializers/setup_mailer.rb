require 'development_mail_interceptor'

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "latoto.cz",
  :user_name            => "jamie.piske",
  :password             => "jamie1234",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

#ActionMailer::Base.delivery_method = :sendmail
#ActionMailer::Base.sendmail_settings = {
#	:location       => '/usr/sbin/sendmail',
#	:arguments      => '-i -t'
#}

# ActionMailer::Base.delivery_method = :file
# ActionMailer::Base.file_settings = {
# 	:location  =>  Rails.root.join('tmp/mails')	
# }

ActionMailer::Base.default_url_options[:host] = "localhost:3000"

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?




