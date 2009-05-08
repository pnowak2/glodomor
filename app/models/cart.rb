class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add_product(product)
    item = @items.find {|i| i.product == product}
    if(item)
      item.increment_quantity
    else
      @items << CartItem.new(product)
    end
  end

  def total_price
    @items.sum {|i| i.price }
  end

  def total_quantity
    @items.sum {|i| i.quantity}
  end
end