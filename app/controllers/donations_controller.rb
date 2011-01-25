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

  def index
    response.headers['Cache-Control'] = 'public, max-age=300'
    @donation = Donation.new
    @donation.customer = Customer.new
  end

  def retry
    @return_code = flash[:return_code]
    return redirect_to root_url if @return_code.nil?

    @donation = Donation.find(flash[:transaction_reference])
    @error_msg = ERROR_MESSAGES[@return_code]
    render :action => "index"
  end

  def create
    donation = Donation.new(params[:donation])
    donation.customer = Customer.new(params[:customer])
    
    if donation.valid? && donation.customer.valid?
      donation.save
      redirect_to GatewayUrlBuilder.new.to_url donation
    else
      @errors = donation.errors.merge(donation.customer.errors)
      @donation = donation
      render :action => "index"
    end
  end

  def callback
    query_string = {}
    params.each {|k, v| query_string[k] = v unless %w[action controller source].include?(k)}
    given_hash = query_string.delete("vpc_SecureHash")
    return render :status => 403 if given_hash.nil?
    computed_hash = ParamsHasher.new(AppConstants.gateway_secret_hash).to_hash(query_string)
    return render :status => 403 unless computed_hash.upcase == given_hash.upcase
    
    return_code = params["vpc_TxnResponseCode"].to_s
    transaction_reference = params["vpc_MerchTxnRef"].to_s

    donation = Donation.find(transaction_reference)
    donation.return_code = return_code
    donation.save!

    deliver_messages(donation)

    flash[:transaction_reference] = transaction_reference
    flash[:return_code] = return_code

    return redirect_to "/donations/retry" unless return_code == "0"
    return redirect_to donations_complete_path(transaction_reference)
  end

  def complete
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    @transaction_reference = flash[:transaction_reference]
    redirect_to root_url if @transaction_reference.nil?
  end
  
  def deliver_messages(donation)
    if (donation.customer.wants_receipt_by_email? && donation.return_code == "0")
      DonationMailer.delay.donation_confirmation(donation)
    end
    if (donation.customer.wants_receipt_by_snail_mail? && donation.return_code == "0")
      DonationMailer.delay.snail_mail_confirmation(donation)
    end        
  end
  private :deliver_messages
end
