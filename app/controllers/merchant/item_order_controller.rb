class Merchant::ItemOrderController < Merchant::BaseController
  def update
    item_order = ItemOrder.find(params[:item_order_id])
    item_order.update(status: "fulfilled")
    item_order.order.update(status: "packaged") if item_order.order.fulfilled?
    redirect_to "/merchant/orders/#{item_order.order.id}"
  end
end
