class ConfirmationPage < Page
  include WatirHelper

  def successful?
    now = Time.now.to_i
    loop do
      return true if @browser.text.include? 'Thank you!'
      return false if Time.now.to_i - now > 20
      sleep 0.2
    end
  end
end