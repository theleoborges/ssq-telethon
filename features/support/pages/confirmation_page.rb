require File.dirname(__FILE__) + "/page"
class ConfirmationPage < Page
  def check_we_are_on_this_page
    @driver.current_url.should =~ /donations\/complete\/\d+$/
  end
end


