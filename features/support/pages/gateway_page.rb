require File.dirname(__FILE__) + "/page"
class GatewayPage < Page
  def check_we_are_on_this_page
    @driver.current_path.should =~ /\/vpcpay\//
  end

  def pay
    # call the current url and then call the call back url we get as a 302
  end
end


