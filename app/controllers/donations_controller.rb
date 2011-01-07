class DonationsController < ApplicationController
  ERROR_MESSAGES = {
    "0"	=> "Transaction approved",
    "1" => "Transaction could not be processed",
    "E" => "Transaction declined - contact issuing bank",
    "2" => "Transaction declined - contact issuing bank",
    "3"	=> "No reply from Processing Host 4	Card has expired",
    "5"	=> "Insufficient credit"
  }
  
  def create
    transaction_reference = UUID.new.generate(:compact).to_s
    url_builder = GatewayUrlBuilder.new transaction_reference, transaction_reference, params[:amount]
    redirect_to url_builder.to_url
  end
  
  def callback
    @return_code = params["vpc_TxnResponseCode"].to_s
    @error_msg = ERROR_MESSAGES[@return_code]
  end

end
