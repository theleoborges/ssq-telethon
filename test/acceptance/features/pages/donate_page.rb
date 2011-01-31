require File.dirname(__FILE__) + "/page"
class DonatePage < Page

  def visit
     driver.goto 'http://google.com'
  end

  def make_donation details
    @driver.fill_in "amount", :with => details['amount']
    @driver.fill_in "email", :with => details['email']
    @driver.fill_in "email_confirmation", :with => details['email_confirmation']
    @driver.click_button 'pay'
  end
end
