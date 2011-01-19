class Customer < ActiveRecord::Base
  scope :snail_mail_receipt, where(:wants_receipt_by_snail_mail => true)
  scope :email_receipt, where(:wants_receipt_by_email => true)
  
  def to_s
    title + " " + given_name + " " + family_name
  end
end