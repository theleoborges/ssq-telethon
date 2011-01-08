require 'test_helper'

class GatewayUrlBuilderTest < ActiveSupport::TestCase
  test "something interesting" do
    ParamsHasher.any_instance.stubs(:to_hash).returns('84f80a3ae85bbc0ad0b7cf957352569b')
    begin
      donation = Donation.new
      donation.id = 111
      donation.amount = 123.45
    
      expected_url = "https://gateway.com/vpcpay?vpc_AccessCode=access_code&vpc_Amount=12345&vpc_Command=pay&vpc_Locale=en&vpc_MerchTxnRef=111&vpc_Merchant=merchant&vpc_OrderInfo=111&vpc_ReturnURL=http%3A%2F%2Flocalhost%3A3000%2Fgateway_callback&vpc_SecureHash=84f80a3ae85bbc0ad0b7cf957352569b&vpc_Version=1"
      assert_equal expected_url, GatewayUrlBuilder.new.to_url(donation)
    ensure
      ParamsHasher.any_instance.unstub(:to_hash)
    end
  end
end