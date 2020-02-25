class Merchant::ItemsController < Merchant::BaseController
  def show
    @merchant = current_user.merchant
    @items = Item.where("items.merchant_id = #{@merchant.id}")
  end
end
