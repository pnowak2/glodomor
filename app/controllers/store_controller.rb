class StoreController < ApplicationController
  before_filter :require_user, :only => [:checkout]
  
  verify :method => :post, :only => [:add_to_cart, :empty_cart, :update_cart_quantities]
  verify :method => :delete, :only => [:remove_from_cart]

  def index
    @product_categories = ProductCategory.all
  end

  def checkout_confirm
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
      @cart.add_product(product)
      flash[:notice] = "Your cart has been updated with #{product}"
      redirect_to :action => :index
    end
  end

  def empty_cart
    session[:cart] = nil
    flash[:notice] = "Your cart is empty now"
    redirect_to :action => :checkout_confirm
  end
  
  def update_cart_quantities
    items = params[:cart_items]
    @cart = find_cart
    items.each do |k, v| 
      item = @cart.items.find{|i| i.product_id == k.to_i}
      if(item)
        if(v.to_i > 0)
          item.quantity = v.to_i
        else
          @cart.items.delete(item)
        end
        
      end 
    end if items
    
    flash[:notice] = "Your cart has been updated"
    render :action => 'checkout_confirm'
  end
end
