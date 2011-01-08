class DonationsController < ApplicationController
  ERROR_MESSAGES = {
    "0"	=> "Transaction approved",
    "1" => "Transaction could not be processed",
    "E" => "Transaction declined - contact issuing bank",
    "2" => "Transaction declined - contact issuing bank",
    "3"	=> "No reply from Processing Host",
    "4" => "Card has expired",
    "5"	=> "Insufficient credit"
  }
  
  def create
    donation = Donation.new
    donation.customer = Customer.new(params[:customer])
    donation.amount = params[:amount]
    donation.save!

    redirect_to GatewayUrlBuilder.new.to_url donation
  end
  
  def callback
    @return_code = params["vpc_TxnResponseCode"].to_s
    transaction_reference = params["vpc_MerchTxnRef"].to_s

    donation = Donation.find_by_transaction_reference(transaction_reference)
    donation.return_code = @return_code
    donation.save!

    @error_msg = ERROR_MESSAGES[@return_code]
  end
  
  def load_test
    donation = Donation.new
    donation.customer = Customer.new(params[:customer])
    donation.amount = 300
    donation.save!    
  end

end
