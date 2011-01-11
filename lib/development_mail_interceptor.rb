class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "TEST ENV - #{message.to} #{message.subject}"
  end
end