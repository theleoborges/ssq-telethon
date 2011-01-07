class CreateDonations < ActiveRecord::Migration
  def self.up
    create_table :donations do |t|
      t.string :transaction_reference
      t.string :order_info
      t.decimal :amount, :precision => 8, :scale => 2
      t.references(:customer)

      t.timestamps
    end
  end

  def self.down
    drop_table :donations
  end
end
