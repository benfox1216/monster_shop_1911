class Merchant::ItemsController < Merchant::BaseController
  def show
    @merchant = current_user.merchant
    @items = Item.where("items.merchant_id = #{@merchant.id}")
  end

  def activate
    item = Item.find(params[:item_id])
    item.activate
    item.save
    redirect_to '/merchant/items'
    flash[:success] = "#{item.name} is now available for sale."
  end

  def deactivate
    item = Item.find(params[:item_id])
    item.deactivate
    item.save
    redirect_to '/merchant/items'
    flash[:success] = "#{item.name} is no longer available for sale."
  end

  def delete
    item = Item.find(params[:item_id])
    Review.where(item_id: item.id).destroy_all
    item.destroy
    flash[:notice] = "#{item.name} has been deleted."
    redirect_to "/merchant/items"
  end
end
