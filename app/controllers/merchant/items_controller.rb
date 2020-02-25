class Merchant::ItemsController < Merchant::BaseController
  def show
    @merchant = current_user.merchant
    @items = Item.where("items.merchant_id = #{@merchant.id}")
  end

  def activate
    item = Item.find(params[:item_id])
    item.activate
    if item.save
      flash[:success] = "#{item.name} successfully activated."
      redirect_to '/merchant/items'
    else
      flash[:error] = "#{item.name} was not able to be activated"
      redirect_to '/merchant/items'
    end
  end

  def deactivate
    item = Item.find(params[:item_id])
    item.deactivate
    if item.save
      flash[:success] = "#{item.name} successfully deactivated."
      redirect_to '/merchant/items'
    else
      flash[:error] = "#{item.name} was not able to be deactivated"
      redirect_to '/merchant/items'
    end
  end

  def delete
    item = Item.find(params[:id])
    Review.where(item_id: item.id).destroy_all
    item.destroy
    flash[:notice] = "#{item.name} has been removed from items"
    redirect_to "/merchant/items"
  end
end
