class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def self.from_cart_item(cart_item)
    li = self.new
    li.name = cart_item.name
    li.product_id = cart_item.product_id
    li.quantity = cart_item.quantity
    li.price = cart_item.price
    li
  end
end
