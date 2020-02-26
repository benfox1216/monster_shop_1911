class Merchant::ItemsController < Merchant::BaseController
  def show
    @merchant = current_user.merchant
    @items = Item.where("items.merchant_id = #{@merchant.id}")
  end

  def new
    @merchant = current_user.merchant
  end

  def create
    @merchant = current_user.merchant
    item = @merchant.items.create(item_params)
    if item.save
      redirect_to "/merchant/items"
      flash[:success] = "Your new item has been saved."
    else
      flash[:error] = item.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @item = Item.find(params[:item_id])
    @merchant = current_user.merchant
  end

  def update
    @item = Item.find(params[:item_id])
    @merchant = current_user.merchant

    @item.update(user_params)
    redirect_to "/merchant/items"
    flash[:success] = "You have successfully updated #{@item.name}'s information."
  end

  def activate
    item = Item.find(params[:item_id])
    item.activate
    if item.save
      flash[:success] = "#{item.name} successfully activated."
      redirect_to '/merchant/items'
    else
      flash[:error] = "#{item.name} was not able to be activated."
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
      flash[:error] = "#{item.name} was not able to be deactivated."
      redirect_to '/merchant/items'
    end
  end

  def delete
    item = Item.find(params[:id])
    Review.where(item_id: item.id).destroy_all
    item.destroy
    flash[:notice] = "#{item.name} has been deleted."
    redirect_to "/merchant/items"
  end

  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end
end
