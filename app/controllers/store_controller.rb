class StoreController < ApplicationController
  verify :method => :post, :only => [:add_to_cart, :empty_cart, :update_cart_quantities, :checkout]
  verify :method => :delete, :only => [:remove_from_cart]

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
   @products = Product.find(:all,:conditions => [
                                                "name like :name or description like :description", 
                                                {:name=>"%#{param}%", :description =>"%#{param}%"}
                                                ], :order => 'name')
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
      redirect_to checkout_confirm_path
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
  end

end
