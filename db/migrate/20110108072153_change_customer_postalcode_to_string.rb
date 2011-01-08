class ChangeCustomerPostalcodeToString < ActiveRecord::Migration
  def self.up
    change_column :customers, :postalcode, :string
  end

  def self.down
    change_column :customers, :postalcode, :integer
  end
end
