class Donation < ActiveRecord::Base
  belongs_to :customer
  validates_presence_of :transaction_reference, :order_info
  validates_numericality_of :amount, :greater_than_or_equal_to => 1.00

  after_initialize do
    self.generate_identifiers! if new_record?
  end

  def generate_identifiers!
    @@uuid_generator ||= UUID.new
    self.order_info = self.transaction_reference = @@uuid_generator.generate(:compact).to_s
  end
end
