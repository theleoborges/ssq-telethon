class Customer < ActiveRecord::Base
  validates_presence_of :email, :if => :wants_receipt_by_email
  validates_presence_of :address_line_1, :city, :state, :postalcode, :country, :if => :wants_receipt_by_snail_mail
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true
  validates_confirmation_of :email
end
