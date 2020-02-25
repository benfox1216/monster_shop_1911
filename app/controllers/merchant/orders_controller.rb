class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find_by(id: params[:id])
  end
end
