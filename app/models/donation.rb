class Donation < ActiveRecord::Base
  belongs_to :customer
  validates_presence_of :amount, :transaction_reference, :order_info
end
