require 'test_helper'

class GatewayUrlBuilderTest < ActiveSupport::TestCase
  test "something interesting" do
    ParamsHasher.any_instance.stubs(:to_hash).returns('84f80a3ae85bbc0ad0b7cf957352569b')
    begin
      builder = GatewayUrlBuilder.new("txn1", "order1", 100)
    
      expected_url = "https://gateway.com/vpcpay?vpc_Version=1&vpc_Locale=en&vpc_Command=pay&vpc_Merchant=merchant&vpc_AccessCode=access_code&vpc_ReturnURL=http://localhost:3000/gateway_callback&vpc_MerchTxnRef=txn1&vpc_OrderInfo=order1&vpc_Amount=100&vpc_SecureHash=84f80a3ae85bbc0ad0b7cf957352569b"
      assert_equal expected_url, builder.to_url
    ensure
      ParamsHasher.any_instance.unstub(:to_hash)
    end
  end
end