class Customer < ActiveRecord::Base
  validates_presence_of :email, :if => :wants_receipt_by_email
  validates_presence_of :address_line_1, :city, :state, :postalcode, :country, :if => :wants_receipt_by_snail_mail
end
