class Admin::UserController < Admin::BaseController
  def show
    @user = User.find(params[:user_id])
  end
end