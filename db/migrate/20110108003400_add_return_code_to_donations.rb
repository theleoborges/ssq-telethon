class AddReturnCodeToDonations < ActiveRecord::Migration
  def self.up
    add_column :donations, :return_code, :string
  end

  def self.down
    remove_column :donations, :return_code
  end
end
