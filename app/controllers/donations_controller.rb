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
    donation = Donation.new
    donation.customer = Customer.new(params[:customer])
    donation.transaction_reference = generate_transaction_reference()
    donation.amount = params[:amount]
    donation.save!

    redirect_to_payment_gateway donation
  end

  def generate_transaction_reference
    @uuid_generator ||= UUID.new
    @uuid_generator.generate(:compact).to_s
  end

  def redirect_to_payment_gateway donation
    url_builder = GatewayUrlBuilder.new donation.transaction_reference, donation.transaction_reference, (donation.amount * 100).to_i
    redirect_to url_builder.to_url
  end
  
  def callback
    @return_code = params["vpc_TxnResponseCode"].to_s
    @error_msg = ERROR_MESSAGES[@return_code]
  end

end
