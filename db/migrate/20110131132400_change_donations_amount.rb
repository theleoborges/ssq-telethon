class ChangeDonationsAmount < ActiveRecord::Migration
  def self.up
    change_column :donations, :amount, :decimal, :precision => 10, :scale => 2
  end

  def self.down
    change_column :donations, :amount, :decimal, :precision => 8, :scale => 2
  end
end