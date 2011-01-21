require File.dirname(__FILE__) + "/page"
class PaymentGatewayPage < Page
  def check_we_are_on_this_page
    @driver.current_path.should =~ /.+vpcpay.*\/?$/
  end
end
