class AccountActivationsController < ApplicationController
  before_action :load_user, only: :edit

  def edit
    if !@user.activated_at? && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      flash[:success] = t "users.acc_activated"
      redirect_to @user
    else
      flash[:danger] = t "users.invalid_link"
      redirect_to root_path
    end
  end

  private

  def load_user
    @user = User.find_by email: params[:email].downcase
    return if @user

    flash[:danger] = t "users.nil"
    redirect_to root_path
  end
end
