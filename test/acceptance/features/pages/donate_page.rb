class DonatePage < Page
  include WatirHelper

  text_field :amount
  text_field :email
  text_field :email_confirmation
  button :pay

  def visit
     browser.goto base_url
  end

  def make_donation details
    self.amount = details['amount']
    self.email = details['email']
    self.email_confirmation = details['email']
    pay
  end
end
