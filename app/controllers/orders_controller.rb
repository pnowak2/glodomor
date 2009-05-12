class OrdersController < ApplicationController
  def index
    @orders = current_user.orders if current_user
  end

end
