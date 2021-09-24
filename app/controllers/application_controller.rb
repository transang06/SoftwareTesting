class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale, :init_cart

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "users.please_login"
    redirect_to login_path
  end

  def init_cart
    session[:cart] ||= {}
  end

  def is_admin?
    return if current_user.admin?

    flash[:warning] = t "receipt.not_permissions"
    redirect_to root_url
  end
end
