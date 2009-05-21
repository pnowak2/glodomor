class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add_product(product, property, quantity)
    item = @items.find {|i| i.product_id == product.id}
    if(item)
      item.increment_quantity(quantity)
    else
      @items << CartItem.new(product.id, product.name, product.price, quantity) if quantity > 0
    end
  end
  
  def remove_product(product_id)
    item = @items.find {|i| i.product_id == product_id}
    if(item)
      if(item.quantity>1)
        item.decrement_quantity
      else
        @items.delete(item)
      end
      
    end
  end

  def total_price
    @items.sum {|i| i.price }
  end

  def total_quantity
    @items.sum {|i| i.quantity}
  end
  
  def is_empty?
    @items.size <=0
  end

  def [](key)
    @items.each do |i|
      if(i.product_id == key)
        return i
      end
    end
    nil
  end
end
