class Admin::SessionController < AdminController
  skip_before_action :check_login
  layout false
  def new
  end

  def create
    prms = params.permit(:username, :password)
    admin = Admin::User.find_by_username(prms[:username]).try(:authenticate, prms[:password])
    if admin
      session[:user_id] = admin.id
      session[:username] = admin.username
      redirect_to admin_path
    else
      redirect_to admin_login_path
    end
  end

  def destroy
    session[:user_id] = session[:username] = nil
    redirect_to admin_login_path
  end
end
