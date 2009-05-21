class StoreController < ApplicationController
  verify :method => :post, :only => [:add_to_cart, :empty_cart, :checkout]

  before_filter :validate_checkout, :only => [:checkout]
  before_filter :require_user, :only => [:checkout]
  
  def index
    @product_categories = ProductCategory.all(:order => 'name')
  end
  
  def home
  end

  def search
    param = params[:phrase]
    if(param.blank?) 
      redirect_to store_path
      return
   end
   @products = Product.available.find(:all,:conditions => [
                                                "name like :name or description like :description", 
                                                {:name=>"%#{param}%", :description =>"%#{param}%"}
                                                ], :order => 'name')
  end

  def my_cart
    flash[:notice] = "Your cart is empty" if @cart.is_empty?
  end

  def checkout_confirm
    if(find_cart.is_empty?)
      redirect_to my_cart_path
    end
    @order = Order.new
  end
    
  def add_to_cart
    begin
      basket = params[:basket]
      product = Product.find(basket[:product_id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      flash[:notice] = "This product does not exist anymore"
      redirect_to store_path
    else
      @cart = find_cart
      if product.available?
        @cart.add_product(product) 
        flash[:notice] = "Your cart has been updated with #{product}"
        redirect_to my_cart_path
      else
        flash[:notice] = "This item is no longer available. Please try again later."
        redirect_to product_path(product)
      end
    end
  end

  def empty_cart
    session[:cart] = nil
    flash[:notice] = "Your cart is empty now"
    redirect_to :action => :my_cart
  end

  def update_cart
    items = params[:cart_item]
    @order = Order.new
    @cart = find_cart
    items.each do |k, v|
      item = @cart[k.to_i]
      if(item)
        if(items[k][:quantity].to_i<=0 || items[k][:deleted])
          @cart.items.delete(item)
        else
          item.quantity = items[k][:quantity].to_i
        end
      end
    end if items

    flash[:notice] = "Your cart has been updated"
    render :action => 'my_cart'
  end

  def checkout
    @cart = find_cart

    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    @order.user = current_user if current_user
    
    if(@order.save)
      @cart.items.each do |i|
        p = Product.find(i.product_id)
        if(p.inventory && p.inventory > 0)
          p.inventory-=i.quantity
          p.save!
        end
      end
    
      flash[:notice] = "Your order have been completed"
      session[:cart] = nil
      redirect_to my_orders_path
    else
      render :action => 'checkout_confirm'
    end
  end

  private

  def validate_checkout
    if(find_cart.is_empty?)
      flash[:notice] = "Your cart is empty"
      redirect_to store_path
    end

    unavailable_products = []
    find_cart.items.each do |i|
      if(!Product.exists?(i.product_id))
        unavailable_products << (i.name + " - does not exist")
      else
        p = Product.find(i.product_id)
        if (!p.available?(i.quantity))
          unavailable_products << (i.name + " - not enough items (#{p.inventory} items left) or item not available")
        end
      end     
    end
    
    unless unavailable_products.empty?
      flash[:notice] = "These items are no longer available:<br/> #{unavailable_products.join('<br/> ')}"
      redirect_to my_cart_path 
    end  
  end

end
