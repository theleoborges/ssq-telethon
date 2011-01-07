require 'params_hasher'

class GatewayUrlBuilder
  # transaction_reference - this is a unique number that identifies this transaction between the app and the gateway
  # order_info - this is the same thing, but identifies the transaction between the app and the user; can be the same as the transaction_reference

  def to_url(donation)
    params = {
      :vpc_Version     =>  1,
      :vpc_Locale      =>  "en",
      :vpc_Command     =>  "pay",
      :vpc_Merchant    =>  AppConstants.merchant_id,
      :vpc_AccessCode  =>  AppConstants.gateway_access_code,
      :vpc_ReturnURL   =>  AppConstants.gateway_callback_uri,
      :vpc_MerchTxnRef =>  donation.transaction_reference,
      :vpc_OrderInfo   =>  donation.order_info,
      :vpc_Amount      =>  (donation.amount * 100).to_i
    }
    params[:vpc_SecureHash] = ParamsHasher.new(AppConstants.gateway_secret_hash).to_hash(params)

    queryString = params.collect do |elem|
      "#{CGI.escape(elem[0].to_s)}=#{CGI.escape(elem[1].to_s)}"
    end
    "#{AppConstants.gateway_payment_uri}?#{queryString.sort.join("&")}"
  end

end