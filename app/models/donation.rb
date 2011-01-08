class Donation < ActiveRecord::Base
  belongs_to :customer
  validates_numericality_of :amount, :greater_than_or_equal_to => 1.00

  after_save :set_transaction_and_order
  def set_transaction_and_order
    self.order_info = self.id
    self.transaction_reference = self.id
  end
end
