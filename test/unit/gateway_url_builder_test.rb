require 'test_helper'

class GatewayUrlBuilderTest < ActiveSupport::TestCase
  test "something interesting" do
    ParamsHasher.any_instance.stubs(:to_hash).returns('84f80a3ae85bbc0ad0b7cf957352569b')
    begin
      donation = Donation.new
      donation.transaction_reference = "txn1"
      donation.order_info = "order1"
      donation.amount = 123.45
    
      expected_url = "https://gateway.com/vpcpay?vpc_Version=1&vpc_Locale=en&vpc_Command=pay&vpc_Merchant=merchant&vpc_AccessCode=access_code&vpc_ReturnURL=http%3A%2F%2Flocalhost%3A3000%2Fgateway_callback&vpc_MerchTxnRef=txn1&vpc_OrderInfo=order1&vpc_Amount=12345&vpc_SecureHash=84f80a3ae85bbc0ad0b7cf957352569b"
      assert_equal expected_url, GatewayUrlBuilder.new.to_url(donation)
    ensure
      ParamsHasher.any_instance.unstub(:to_hash)
    end
  end
end