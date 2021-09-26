class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      pass_authen user
    else
      flash.now[:danger] = t "users.invalid_email"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def pass_authen user
    if user.activated_at?
      log_in user
      return redirect_to admin_root_path if user.admin?

      redirect_back_or user
    else
      flash[:warning] = t "users.acc_not_acti"
      redirect_to root_url
    end
  end
end
