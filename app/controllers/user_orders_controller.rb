class UserOrdersController < ApplicationController
  def index
    @user_orders = Order.where(user_id: current_user.id)
  end
  
  def show
    @order = Order.find(params[:order_id])
  end
  
  def update
    ItemOrder.where(order_id: params[:order_id]).each do |item_order|
      item_order.update(status: "unfulfilled")
      item = item_order.item
      item_order.item.update(inventory: item.inventory += item_order.quantity)
    end

    order = Order.find(params[:order_id]).update(status: "cancelled")
    redirect_to '/profile'
    flash[:success] = "Your order has been cancelled"
  end
end