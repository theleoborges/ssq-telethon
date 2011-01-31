class Donation < ActiveRecord::Base
  belongs_to :customer
  validates_numericality_of :amount, :greater_than_or_equal_to => 1.00, :message => "invalid number - use one or two decimal places, or no decimal point",
                                     :less_than => 100000000.00, :message => "invalid number - maximum valid amount is $99'999'999.99"
  validates_associated :customer

  scope :paid, where(:return_code => '0')

  def display_amount
    sprintf "%.2f", self.amount.to_f
  end
  
  def paid?
    return_code == "0"
  end
end
