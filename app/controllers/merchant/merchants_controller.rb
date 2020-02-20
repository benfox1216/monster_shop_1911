class Merchant::DashboardController < Merchant::BaseController
    def index
      @orders = current_user.merchant.orders.distinct
    end