class UsersController < ApplicationController
  def new
  end
  
  def show
    
  end
  
  def create
    User.create(user_params)
    
    redirect_to "/profile"
    flash[:success] = "You are now registered and logged in"
  end
  
  private
  
    def user_params
      params.permit(:name, :address, :city, :state, :zip, :email, :password)
    end
end