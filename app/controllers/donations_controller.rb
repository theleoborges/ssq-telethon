class DonationsController < ApplicationController
  def create
    transaction_reference = UUID.new.generate(:compact).to_s
    url_builder = GatewayUrlBuilder.new transaction_reference, transaction_reference, params[:amount]
    redirect_to url_builder.to_url
  end
  
  def callback
    @request = request
  end

end
