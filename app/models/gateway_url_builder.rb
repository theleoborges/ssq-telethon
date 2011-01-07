require 'params_hasher'

class GatewayUrlBuilder
  # transaction_reference - this is a unique number that identifies this transaction between the app and the gateway
  # order_info - this is the same thing, but identifies the transaction between the app and the user. Not sure if it can be the same
  attr_reader :transaction_reference, :order_info, :amount

  def initialize(transaction_reference, order_info, amount)
    @transaction_reference = transaction_reference
    @order_info = order_info
    @amount = amount.to_s
  end

  def to_url
    params = {
      :vpc_Version     =>  1,
      :vpc_Locale      =>  "en",
      :vpc_Command     =>  "pay",
      :vpc_Merchant    =>  AppConstants.merchant_id,
      :vpc_AccessCode  =>  AppConstants.gateway_access_code,
      :vpc_ReturnURL   =>  AppConstants.gateway_callback_uri,
      :vpc_MerchTxnRef =>  transaction_reference,
      :vpc_OrderInfo   =>  order_info,
      :vpc_Amount      =>  amount
    }
    params[:vpc_SecureHash] = ParamsHasher.new(AppConstants.gateway_secret_hash).to_hash(params)

    AppConstants.gateway_payment_uri + '?' + URI.encode_www_form(params)
  end
  

end