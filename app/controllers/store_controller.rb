class StoreController < ApplicationController

  verify :method => :post, :only => [:add_to_cart, :empty_cart, :update_cart_quantities]
  verify :method => :delete, :only => [:remove_from_cart]

  def index
    @product_categories = ProductCategory.all
  end

  def checkout_confirm
    @order = Order.new
    flash[:notice] = "Your cart is empty" if @cart.is_empty?
  end
    
  def add_to_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      flash[:notice] = "Invalid product"
    else
      @cart = find_cart
      @cart.add_product(product) if product.published
      flash[:notice] = "Your cart has been updated with #{product}"
      redirect_to :action => :index
    end
  end

  def empty_cart
    session[:cart] = nil
    flash[:notice] = "Your cart is empty now"
    redirect_to :action => :checkout_confirm
  end

  def update_cart
    items = params[:cart_item]
    @order = Order.new
    @cart = find_cart
    items.each do |k, v|
      item = @cart.items.find{|i| i.product_id == k.to_i}
      if(item)
        if(items[k][:quantity].to_i<=0 || items[k][:deleted])
          @cart.items.delete(item)
        else
          item.quantity = items[k][:quantity].to_i
        end
      end
    end if items

    flash[:notice] = "Your cart has been updated"
    render :action => 'checkout_confirm'
  end

  def checkout
    @cart = find_cart
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)
    @order.user = current_user if current_user

    if(@order.save)
      flash[:notice] = "Your order have been completed"
      session[:cart] = nil
      redirect_to orders_path
    else
      render :action => 'checkout_confirm'
    end
  end

end
