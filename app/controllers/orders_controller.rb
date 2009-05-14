class OrdersController < ApplicationController

  before_filter :require_user_admin, :only => [:index]
  before_filter :require_user

  def index
    @orders = Order.all(:include => [:line_items, :user])
  end

  def my_orders
    @orders = current_user.orders if current_user
  end

end
