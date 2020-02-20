class LoginController <ApplicationController

    def new 
    end 

    def create
        user = User.find_by(email_address: params[:email])
        if user.password == user_params[:password]
            user.save
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
            flash[:error] = 'Invalid email or password'
        end 
    end

    private

    def user_params
        params.permit(:name, :email, :password) 
    end
end 