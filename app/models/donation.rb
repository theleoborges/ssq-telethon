class Donation < ActiveRecord::Base
  belongs_to :customer
  validates_numericality_of :amount, :greater_than_or_equal_to => 2.00, :message => "invalid number - the minimum donation is $2 - use one or two decimal places, or no decimal point"
  validates_numericality_of :amount, :less_than_or_equal_to => 20000000.00, :message => "invalid number - the maximum allowable donation is $20,000,000.00"
  validates_associated :customer

  scope :paid, where(:return_code => '0')
  scope :unpaid, where(:return_code => nil)
  
  def mark_as_paid
    self.return_code = '0'
    self.save
  end

  def display_amount
    sprintf "%.2f", self.amount.to_f
  end
  
  def paid?
    return_code == "0"
  end
  
  def unpaid?
    !paid?
  end

  def status
    paid? ? 'Paid' : 'Unpaid'
  end
end
