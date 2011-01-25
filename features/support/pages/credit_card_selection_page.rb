require File.dirname(__FILE__) + "/page"
class CreditCardSelectionPage < Page
  def check_we_are_on_this_page
    @driver.current_path.should =~ /.+vpcpay.*\/?$/
  end
end


@driver.find(:xpath, "//a[contains(@href,'Visa')]").click

 #@driver.current_path.should =~ /.+vpcpay.*\/?$/
  #@driver.fill_in "", :with => listing['card_type']
  #@driver.fill_in "", :with => listing['number']
  #@driver.fill_in "", :with => listing['month']
  #@driver.fill_in "", :with => listing['year']