class UserOrdersController < ApplicationController
  def index
    @user_orders = Order.where(user_id: current_user.id)
  end
  
  def show
    @order = Order.find(params[:order_id])
  end
end