class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :title
      t.string :given_name
      t.string :family_name
      t.string :organisation_name
      t.string :phone
      t.string :fax
      t.boolean :wants_receipt_by_email
      t.string :email
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :city
      t.string :state
      t.integer :postalcode
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
