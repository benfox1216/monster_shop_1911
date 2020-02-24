class UserOrdersController < ApplicationController
  def index
    @user_orders = Order.where(user_id: current_user.id)
  end
end