class LoginController < ApplicationController
  def new
    if current_user
      if current_user.default?
      redirect_to '/profile'
    elsif current_user.merchant?
      redirect_to '/merchant'
    elsif current_user.admin?
      redirect_to admin_path
    end
      flash[:error] = "#{current_user.name}, you already logged in."
    end
  end

  def create
    user = User.find_by(email_address: user_params[:email])
    if user.authenticate(user_params[:password])
      if user.default?
        redirect_to '/profile'
      elsif user.merchant?
        redirect_to '/merchant'
      elsif user.admin?
        redirect_to admin_path
      end
      session[:user_id] = user.id
      flash[:success] = "#{user.name}, you are now logged in!"
    else
      flash[:error] = 'Invalid credentials'
      redirect_to '/login'
    end
  end

  def empty
    session.delete(:user_id)
    session.delete(:cart)
    redirect_to '/'
    flash[:success] = "You have logged out"
  end


  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
