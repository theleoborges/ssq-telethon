When /^I enter details to make a donation and continue:$/ do |table|
  details = table.rows_hash
  goto(DonatePage) do |page|
    page.make_donation details
  end
end

When /^I enter my credit card details$/ do |table|
  cc_details = table.rows_hash
  on(CreditCardSelectionPage) do |page|
    page.choose cc_details['card_type']
  end

  on(CreditCardDetailsPage) do |page|
    page.pay cc_details['number'], cc_details['month'], cc_details['year'] 
  end
end

Then /^I get a confirmation that my donation was made$/ do
  on ConfirmationPage do |page|
    raise "Donation was not successful" unless page.successful?
  end
end

When /^pay via the payment gateway$/ do
  on GatewayPage do |page|
    page.pay_with :provider => :visa, :number => '4005 5500 0000 0001', :month => '05', :year => '13'
  end
end