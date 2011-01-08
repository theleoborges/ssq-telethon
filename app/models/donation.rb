class Donation < ActiveRecord::Base
  belongs_to :customer
  validates_numericality_of :amount, :greater_than_or_equal_to => 1.00
  
  def display_amount
    sprintf "%.2f", self.amount.to_f
  end
  
end
