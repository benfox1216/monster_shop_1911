class Merchant::ItemOrderController < Merchant::BaseController
  def update
    item_order = ItemOrder.find(params[:item_order_id])
    item_order.update(status: "fulfilled")

    new_inventory = (item_order.item.inventory -= item_order.quantity)

    item_order.item.update(inventory: new_inventory)
    
    item_order.order.update(status: "packaged") if item_order.order.fulfilled?
    redirect_to "/merchant/orders/#{item_order.order.id}"
    flash[:success] = "You have fulfilled the order for #{item_order.item.name}"
  end
end
