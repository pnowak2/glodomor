class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  
  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
  end
end
