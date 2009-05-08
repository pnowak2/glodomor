class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add_product(product)
    item = @items.find {|i| i.product_id == product.id}
    if(item)
      item.increment_quantity
    else
      @items << CartItem.new(product.id, product.name, product.price)
    end
  end

  def total_price
    @items.sum {|i| i.price }
  end

  def total_quantity
    @items.sum {|i| i.quantity}
  end
end
