class GatewayPage < Page
  include WatirHelper

  link :visa, {:href => /Visa/}
  link :amex, {:href => /Amex/}
  link :mastercard, {:href => /Mastercard/}

  text_field :number, {:id => 'CardNumber'}
  text_field :month, {:id => 'CardMonth'}
  text_field :year, {:id => 'CardYear'}
  text_field :code, {:id => 'Securecode'}
  button :pay, {:id => 'Paybutton'}
  
  def pay_with card
    self.send card[:provider]
    self.number = card[:number]
    self.month = card[:month]
    self.year = card[:year]
    self.code = card[:code]
    pay
  end
end