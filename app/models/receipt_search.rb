class ReceiptSearch
  require 'timeliness'
  include ActiveModel::Validations
 
  validates_numericality_of :receipt_number, :greater_than_or_equal_to => 3000000, :message => "please enter a valid receipt number", :allow_blank => true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1.00, :message => "invalid number - use one or two decimal places, or no decimal point", :allow_blank => true
  validates_format_of :email_address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "invalid email", :allow_blank => true
  validates_date :donation_date, :message => "invalid date - use dd/mm/yyyy", :allow_blank => true
 
  attr_accessor :receipt_number, :given_name, :family_name, :organisation_name, :email_address, :donation_date, :amount
  
  def initialize(params = {})
    @receipt_number, @given_name, @family_name, @organisation_name, @email_address, @donation_date, @amount = params[:receipt_number], params[:given_name], params[:family_name], params[:organisation_name], params[:email_address], params[:donation_date], params[:amount]
  end
end