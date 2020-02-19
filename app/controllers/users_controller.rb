class UsersController < ApplicationController
  def new
  end
  
  def show
  end
  
  def create
    user = User.create(user_params)
    
    if user.save
      redirect_to "/profile"
      flash[:success] = "You are now registered and logged in"
    else
      redirect_to "/register"
      flash[:error] = user.errors.full_messages.to_sentence
    end
  end
  
  private
  
    def user_params
      params.permit(:name, :address, :city, :state, :zip_code, :email_address, :password)
    end
end