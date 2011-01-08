require 'development_mail_interceptor'

if Rails.env.development?
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "leonardoborges.com",
    :user_name            => "do-not-reply@leonardoborges.com",
    :password             => "labemoldelivery",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }
end

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
