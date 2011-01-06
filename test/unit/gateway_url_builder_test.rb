require 'test_helper'

class GatewayUrlBuilderTest < ActiveSupport::TestCase
  test "something interesting" do
    builder = GatewayUrlBuilder.new
    assert_equal builder.to_url, "https://203.202.39.43/vpcpay?vpc_Version=1&vpc_Locale=en&vpc_Command=pay&vpc_AccessCode=A53853CE&vpc_MerchTxnRef=123&vpc_Merchant=TESTANDREWK&vpc_OrderInfo=VPC+Example&vpc_Amount=100&vpc_ReturnURL=http://localhost/ASP_VPC_3Party_DR.asp&&vpc_SecureHash=A7F22A5CA87DD2FC6BA3F78359DA639A"
  end
end