class Merchant::DashboardController < Merchant::BaseController

  def index
    @merchant = current_user.merchant

    @item_orders_price =
      @merchant.items.joins(:orders).where("orders.status = 'pending'").distinct.group('orders.id').sum('item_orders.quantity * item_orders.price')

    @item_orders_quantity =
      @merchant.items.joins(:orders).where("orders.status = 'pending'").distinct.group('orders.id').sum('item_orders.quantity')

    @orders = Order.joins(:items).distinct.where("orders.status = 'pending' and items.merchant_id = #{@merchant.id}")
  end
end
