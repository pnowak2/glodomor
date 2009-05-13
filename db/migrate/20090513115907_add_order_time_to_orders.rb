class AddOrderTimeToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :order_time, :datetime
  end

  def self.down
    remove_column :orders, :order_time
  end
end
