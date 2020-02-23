class LoginController <ApplicationController

  def new
    if current_user
      redirect_to '/'
      flash[:error] = "#{current_user.name}, you already logged in."
    end
  end

  def create
    user = User.find_by(email_address: params[:email])
    if user.authenticate(params[:password])
      if user.default?
        redirect_to user_path
      elsif user.merchant?
        redirect_to merchant_path
      elsif user.admin?
        redirect_to admin_path
      end
      session[:user_id] = user.id
      flash[:success] = "#{user.name}, you are now logged in!"
    else
      flash[:error] = 'Invalid credentials'
      redirect_to login_path
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
