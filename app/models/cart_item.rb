class CartItem

  attr_reader :product_id, :name, :price
  attr_reader :quantity

  def initialize(product_id, name, price)    @product_id = product_id
    @name = name;
    @price = price
    @quantity = 1;
  end
  
  def increment_quantity
    @quantity += 1
  end
  
  def decrement_quantity
    @quantity -= 1 if @quantity > 0
  end
  def price
    @price * @quantity
  end
  def quantity=(q)
    @quantity = q if q>=0
  end

  def title
    @name
  end

end
