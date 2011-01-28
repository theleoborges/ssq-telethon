require File.dirname(__FILE__) + "/page"
class CreditCardSelectionPage < Page
  def check_we_are_on_this_page
    @driver.current_path.should =~ /.+vpcpay.*\/?$/
  end

  def choose card_type
    p @driver.source
    @driver.find(:xpath, "//a[contains(@href,'#{card_type}')]").click
  end
end


