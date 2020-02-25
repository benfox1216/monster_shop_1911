class Admin::MerchantsController < Admin::BaseController

  def index
   @merchants =  Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.enabled?
      merchant.update(status: 1)
      merchant.deactivate_items
      flash[:success] = "#{merchant.name} has been disabled"
    else
      merchant.update(status: 0)
      merchant.deactivate_items
      flash[:success] = "#{merchantname} has been enabled"
    end
    redirect_to '/admin/merchants'
  end
end
