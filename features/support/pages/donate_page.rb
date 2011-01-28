require File.dirname(__FILE__) + "/page"
class DonatePage < Page

  def visit
     driver.visit '/'
  end

  def make_donation listing
    @driver.fill_in "amount", :with => listing['amount']
    @driver.click_button 'pay'
  end
end
