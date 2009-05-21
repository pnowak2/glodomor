class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def update_product(request, mode)
    product = Product.find(request[:product_id])
    property = Property.find_by_id(request[:property_id])
    item = self[product.id]
    
    unless(product.published?)
      raise Exceptions::CartException.new("This item is not available now (#{product})")
    end
    
    in_basket = (item && mode == :add) ? item.quantity : 0
    unless(product.available?(in_basket + request[:quantity].to_i) )
      raise Exceptions::CartException.new("You can't get more items than in stock for #{product} (#{product.inventory}) - #{request[:quantity]}")
    end
    
    unless(request[:quantity].to_i > 0)
      raise Exceptions::CartException.new("You have to get one or more items for (#{product})")
    end

    if(item)
      if(mode != :add)
         item.quantity = request[:quantity].to_i
      else
         item.increment_quantity(request[:quantity].to_i)
      end
    else
      @items << CartItem.new(product.id, product.name, product.price, request[:quantity].to_i)
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
