class ReceiptSearch
  require 'timeliness'
  include ActiveModel::Validations
 
  validates_numericality_of :receipt_number, :greater_than_or_equal_to => 3000000, :message => "please enter a valid receipt number", :allow_blank => true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1.00, :message => "invalid number - use one or two decimal places, or no decimal point", :allow_blank => true
  validates_date :donation_date, :message => "invalid date - use dd/mm/yyyy", :allow_blank => true

  ATTRIBUTES = [:receipt_number, :given_name, :family_name, :organisation_name, :email_address, :donation_date, :amount, :status]

  attr_accessor *ATTRIBUTES
  
  def initialize params = {}
    ATTRIBUTES.each { |attr| send "#{attr}=", params[attr] }
  end

  def paid?
    status == 'paid'
  end

  def unpaid?
    status == 'unpaid'
  end
end