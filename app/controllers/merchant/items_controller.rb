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

    @item.update(item_params)

    if @item.save
      flash[:success] = "You have successfully updated #{@item.name}'s information."
      redirect_to "/merchant/items"
    else
      flash[:error] = "You must complete all required fields before your item will be updated."
      redirect_to "/merchant/items/#{@item.id}/edit"
    end
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

  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end
end
