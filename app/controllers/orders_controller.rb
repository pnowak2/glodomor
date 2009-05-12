class OrdersController < ApplicationController

  before_filter :require_user

  def index
    @orders = current_user.orders if current_user
  end

end
