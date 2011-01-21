When /^I enter details to make a donation and continue:$/ do |table|
  details = table.rows_hash
  goto(DonatePage) do |page|
    page.make_donation details
  end
end

Then /^I should see the payment gateway$/ do
  on(PaymentGatewayPage)
end
