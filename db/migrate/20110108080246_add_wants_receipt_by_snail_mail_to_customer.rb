class AddWantsReceiptBySnailMailToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :wants_receipt_by_snail_mail, :boolean
  end

  def self.down
    remove_column :customers, :wants_receipt_by_snail_mail
  end
end
